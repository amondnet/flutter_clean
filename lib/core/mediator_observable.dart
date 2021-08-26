import 'package:mobx/mobx.dart';

import 'resource.dart';

class NullableValue<T> {
  final T? value;
  NullableValue(this.value);
}

class MediatorObservable<T>
    implements
        Interceptable<Resource<T>>,
        Listenable<ChangeNotification<Resource<T>>>,
        ObservableValue<Resource<T>> {
  Map<Observable, _Source> sources = {};
  Observable<Resource<T>> _observable = Observable(Resource.loading(null));

  void addSource<S>(Observable<S> source, void Function(S s) onChanged) {
    _Source<S> e = _Source<S>(source, onChanged);

    var existing = sources[source];
    if (existing == null) {
      sources[source] = e;
    }

    if (existing != null && existing.observer != onChanged) {
      throw new ArgumentError(
          "This source was already added with the different observer");
    }
    if (existing != null) {
      return;
    }

    if (_observable.hasObservers == true) {
      e.plug();
    }
    //if ( has)
  }

  /// Stops to listen the given [Observable].
  void removeSource<S>(Observable<S> toRemote) {
    final source = sources.remove(toRemote);
    if (source != null) {
      source.unplug();
    }
  }

  @override
  Dispose intercept(Interceptor<Resource<T>> interceptor) {
    return _observable.intercept(interceptor);
  }

  @override
  Dispose observe(Listener<ChangeNotification<Resource<T>>> listener,
      {bool fireImmediately = false}) {
    // TODO: implement observe
    throw UnimplementedError();
  }

  @override
  Resource<T> get value => _observable.value;

  set value(value) => _observable.value = value;

  Observable<Resource<T>> get observable => _observable;
}

class _Source<V> {
  final ObservableValue<V> observable;
  late Function(V) observer;
  V? value;
  ReactionDisposer? _disposer;

  _Source(this.observable, Function(V) observer) {
    this.observer = (V v) {
      if (v != value) {
        value = v;
        observer(v);
      }
    };
  }

  void plug() {
    _disposer = reaction((_) => observable.value, observer);
    //observable.observe(() {})
  }

  void unplug() {
    _disposer?.call();
    _disposer = null;
  }
}
