import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

@immutable
class AsyncResult<T> {
  final bool loading;

  final T value;

  final Object error;

  const AsyncResult._({this.loading = false, this.value, this.error});

  factory AsyncResult.loading() => const AsyncResult._(loading: true);

  factory AsyncResult.value(T value) => AsyncResult._(value: value);

  factory AsyncResult.error(Object error) {
    assert(error != null);
    return AsyncResult._(error: error);
  }

  R when<R>({
    @required R Function() isLoading,
    @required R Function(T) isValue,
    @required R Function(Object) isError,
  }) {
    assert(isLoading != null);
    assert(isValue != null);
    assert(isError != null);

    if (this.loading) {
      return isLoading();
    }
    if (this.error != null) {
      return isError(this.error);
    }
    return isValue(value);
  }
}

abstract class AsyncResultListenable<T>
    extends ValueListenable<AsyncResult<T>> {}

class AsyncResultNotifier<T> extends ValueNotifier<AsyncResult<T>>
    implements AsyncResultListenable<T> {
  AsyncResultNotifier() : super(AsyncResult.loading());

  AsyncResultNotifier.withValue(T value) : super(AsyncResult.value(value));

  AsyncResultNotifier.withError(Object error) : super(AsyncResult.error(error));

  @override
  set value(AsyncResult<T> newValue) {
    assert(newValue != null);
    super.value = newValue;
  }

  void setLoading() {
    super.value = AsyncResult.loading();
  }

  void setValue(T value) {
    super.value = AsyncResult.value(value);
  }

  void setError(Object error) {
    super.value = AsyncResult.error(error);
  }
}

class AsyncResultListenableBuilder<T>
    extends ValueListenableBuilder<AsyncResult<T>> {
  const AsyncResultListenableBuilder({
    @required AsyncResultListenable<T> listenable,
    @required ValueWidgetBuilder<AsyncResult<T>> builder,
    Widget child,
  })  : assert(listenable != null),
        assert(builder != null),
        super(
          valueListenable: listenable,
          builder: builder,
          child: child,
        );
}
