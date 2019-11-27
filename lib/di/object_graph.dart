typedef Factory<T> = T Function(ObjectResolver resolver);

abstract class ObjectResolver {
  T resolve<T>([String name]);
}

abstract class ObjectRegistrar {
  void registerFactory<T>(Factory<T> factory, {String name});

  void registerSingleton<T>(T singleton, {String name});

  void registerLazySingleton<T>(Factory<T> factory, {String name});
}

abstract class ObjectGraph implements ObjectRegistrar, ObjectResolver {}
