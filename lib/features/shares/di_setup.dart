import 'package:chopper/chopper.dart';
import 'package:kiwi/kiwi.dart' as di;
import 'package:com.example.moex/db/database_provider.dart';
import 'package:com.example.moex/features/shares/data/shares_data_source.dart';

import 'data/local/local_data_source.dart';
import 'data/remote/api/shares_api.dart';
import 'data/remote/remote_data_source.dart';
import 'data/shares_repository_impl.dart';
import 'domain/shares_repository.dart';
import 'ui/shares_vm.dart';

void registerArtifacts(di.Container container) {
  container.registerSingleton<SharesApi>((c) {
    final chopper = c.resolve<ChopperClient>();
    return SharesApi.create(chopper);
  });

  container.registerSingleton((c) => DatabaseProvider());

  container.registerSingleton<SharesDataSource>(
    (c) => LocalDataSource(c.resolve()),
    name: 'local',
  );

  container.registerSingleton<SharesDataSource>(
    (c) => RemoteDataSource(c.resolve()),
    name: 'remote',
  );

  container.registerSingleton<SharesRepository>(
    (c) {
      return SharesRepositoryImpl(
        c.resolve('local'),
        c.resolve('remote'),
      );
    },
  );

  container.registerFactory((c) => SharesVm(c.resolve()));
}
