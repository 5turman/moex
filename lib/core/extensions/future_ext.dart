import 'dart:async';

import 'package:async/async.dart';

extension FutureExtension<T> on Future<T> {
  CancelableOperation<T> toCancelableOperation({FutureOr onCancel()}) {
    return CancelableOperation.fromFuture(this, onCancel: onCancel);
  }
}
