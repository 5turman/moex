import 'package:com.example.moex/di/object_graph.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

class KiwiObjectGraph implements ObjectGraph {
  final _container = kiwi.Container();

  @override
  void registerFactory<T>(Factory<T> factory, {String name}) {
    _container.registerFactory<T>(
      (c) => factory(this),
      name: name,
    );
  }

  @override
  void registerLazySingleton<T>(Factory<T> factory, {String name}) {
    _container.registerSingleton<T>(
      (c) => factory(this),
      name: name,
    );
  }

  @override
  void registerSingleton<T>(T singleton, {String name}) {
    _container.registerInstance<T>(
      singleton,
      name: name,
    );
  }

  @override
  T resolve<T>([String name]) {
    return _container.resolve(name);
  }
}
