import 'package:clean/core/mediator_observable.dart';
import 'package:clean/core/network_response.dart';
import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';

import '../resource.dart';

/// A generic class that can provide a resource backed by both the hive database and the network.
abstract class NetworkBoundResource<ResultType, RequestType> {
  var _result = MediatorObservable<ResultType>();

  @protected
  Observable<ResultType> loadFromDb();

  Observable<Resource<ResultType>> asObservable() => _result.observable;

  NetworkBoundResource() {
    _result.value = Resource.loading(null);

    final dbSource = loadFromDb();
    _result.addSource(dbSource, (ResultType data) {
      _result.removeSource(dbSource);
      if (shouldFetch(data)) {
        _fetchFromNetwork(dbSource);
      } else {
        _result.addSource(dbSource, (ResultType newData) {
          _setValue(Resource(newData));
        });
      }
    });
  }

  @protected
  onFetchFailed() {}

  void _setValue(Resource<ResultType> newValue) {
    if (_result.value != newValue) {
      _result.value = newValue;
    }
  }

  void _fetchFromNetwork(Observable<ResultType> dbSource) {
    final apiResponse = createCall();
    // we re-attach dbSource as a new source, it will dispatch its latest value quickly
    _result.addSource(dbSource, (ResultType newData) {
      _setValue(Resource.loading(newData));
    });

    _result.addSource(apiResponse, (response) {
      _result.removeSource(apiResponse);
      _result.removeSource(dbSource);
      if (response is ApiSuccessResponse<RequestType>) {
        saveCallResult(processResponse(response));
        // we specially request a new live data,
        // otherwise we will get immediately last cached value,
        // which may not be updated with latest results received from network.
        _result.addSource(loadFromDb(), (ResultType newData) {
          _setValue(Resource(newData));
        });
      } else if (response is ApiEmptyResponse<RequestType>) {
        // reload from disk whatever we had
        _result.addSource(loadFromDb(), (ResultType newData) {
          _setValue(Resource(newData));
        });
      } else if (response is ApiErrorResponse) {
        onFetchFailed();
        _result.addSource(dbSource, (ResultType newData) {
          _setValue(Resource.error(response.errorMessage, newData));
        });
      }
      Stream s;
    });
  }

  @protected
  bool shouldFetch(ResultType? data);

  Observable<ApiResponse<RequestType>> createCall();

  @protected
  void saveCallResult(RequestType item);

  RequestType processResponse(ApiSuccessResponse<RequestType> response) =>
      response.data;
}
