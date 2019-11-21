import 'package:built_collection/built_collection.dart';

extension IterableExtension<T> on Iterable<T> {
  BuiltList<T> toBuiltList() => BuiltList(this);
}

extension BuiltListExtension<T> on BuiltList<T> {
  bool get isNullOrEmpty => (this == null || this.isEmpty);

  BuiltList<T> sort([int compare(T a, T b)]) {
    final builder = toBuilder();
    builder.sort(compare);
    return builder.build();
  }
}
