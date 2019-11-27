import 'package:chopper/chopper.dart';
import 'package:com.example.moex/db/database_provider.dart';
import 'package:com.example.moex/di/object_graph.dart';
import 'package:com.example.moex/features/shares/data/shares_data_source.dart';

import 'data/local/local_data_source.dart';
import 'data/remote/api/shares_api.dart';
import 'data/remote/remote_data_source.dart';
import 'data/shares_repository_impl.dart';
import 'domain/shares_repository.dart';
import 'ui/shares_vm.dart';

void registerArtifacts(ObjectGraph objectGraph) {
  objectGraph.registerLazySingleton<SharesApi>((r) {
    final chopper = r.resolve<ChopperClient>();
    return SharesApi.create(chopper);
  });

  objectGraph.registerLazySingleton((r) => DatabaseProvider());

  objectGraph.registerLazySingleton<SharesDataSource>(
    (r) => LocalDataSource(r.resolve()),
    name: 'local',
  );

  objectGraph.registerLazySingleton<SharesDataSource>(
    (r) => RemoteDataSource(r.resolve()),
    name: 'remote',
  );

  objectGraph.registerLazySingleton<SharesRepository>(
    (r) => SharesRepositoryImpl(
      r.resolve('local'),
      r.resolve('remote'),
    ),
  );

  objectGraph.registerFactory((r) => SharesVm(r.resolve()));
}
