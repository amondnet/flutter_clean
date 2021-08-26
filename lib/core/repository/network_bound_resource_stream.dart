import 'dart:async';

import 'package:clean/core/mediator_observable.dart';
import 'package:clean/core/network_response.dart';
import 'package:meta/meta.dart';

import '../resource.dart';

/// A generic class that can provide a resource backed by both the hive database and the network.
abstract class NetworkBoundResourceStream<ResultType, RequestType> {
  StreamController<Resource<ResultType>> _sink = StreamController();

  @protected
  Stream<ResultType> loadFromDb();

  NetworkBoundResourceStream() {
    _sink.add(Resource.loading(null));

    final dbSource = loadFromDb();
    dbSource.single.then((ResultType data) {
      if (shouldFetch(data)) {
        _fetchFromNetwork(dbSource);
      } else {
        _sink.add(Resource(data));
      }
    });
  }

  @protected
  onFetchFailed() {}

  void _setValue(Resource<ResultType> newValue) {
    _sink.add(newValue);
  }

  void _fetchFromNetwork(Stream<ResultType> dbSource) async {
    final apiResponse = createCall();

    // we re-attach dbSource as a new source, it will dispatch its latest value quickly
    final fromDb = await dbSource.single;
    _setValue(Resource.loading(fromDb));

    final response = await apiResponse.distinct().single;

    if (response is ApiSuccessResponse<RequestType>) {
      saveCallResult(processResponse(response));
      // we specially request a new live data,
      // otherwise we will get immediately last cached value,
      // which may not be updated with latest results received from network.
      final fromDb = await dbSource.single;
      _setValue(Resource(fromDb));
    } else if (response is ApiEmptyResponse<RequestType>) {
      // reload from disk whatever we had
      final fromDb = await dbSource.single;
      _setValue(Resource(fromDb));
    } else if (response is ApiErrorResponse<RequestType>) {
      onFetchFailed();
      final fromDb = await dbSource.single;
      _setValue(Resource.error(response.errorMessage, fromDb));
    }
  }

  @protected
  bool shouldFetch(ResultType? data);

  Stream<ApiResponse<RequestType>> createCall();

  @protected
  void saveCallResult(RequestType item);

  RequestType processResponse(ApiSuccessResponse<RequestType> response) =>
      response.data;

  Stream<Resource<ResultType>> get stream => _sink.stream;
}
