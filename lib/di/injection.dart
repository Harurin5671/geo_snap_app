import 'package:get_it/get_it.dart';

import 'package:geo_snap/core/services/camera_service.dart';
import 'package:geo_snap/core/services/location_service.dart';
import 'package:geo_snap/core/services/permission_service.dart';
import 'package:geo_snap/data/local/database/daos/photo_dao.dart';
import 'package:geo_snap/data/datasources/photo_data_source.dart';
import 'package:geo_snap/presentation/blocs/photo/photo_bloc.dart';
import 'package:geo_snap/domain/repositories/photo_repository.dart';
import 'package:geo_snap/data/local/database/geo_snap_database.dart';
import 'package:geo_snap/presentation/blocs/camera/camera_bloc.dart';
import 'package:geo_snap/data/repositories/photo_repository_impl.dart';
import 'package:geo_snap/data/datasources/photo_local_data_source.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {
  // Database y DAO
  sl.registerLazySingleton(() => GeoSnapDatabase());
  sl.registerLazySingleton(() => PhotoDao(sl()));

  // DataSources y Repositories
  sl.registerLazySingleton<PhotoDataSource>(() => PhotoLocalDataSource(sl()));
  sl.registerLazySingleton<PhotoRepository>(() => PhotoRepositoryImpl(sl()));

  // Services
  sl.registerLazySingleton(() => PermissionService());
  sl.registerLazySingleton(() => CameraService(sl()));
  sl.registerLazySingleton(() => LocationService(sl()));

  // Blocs
  sl.registerFactory(
    () => CameraBloc(cameraService: sl(), locationService: sl()),
  );
  sl.registerFactory(() => PhotoBloc(photoRepository: sl()));
}
