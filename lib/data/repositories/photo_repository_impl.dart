import 'dart:developer';

import 'package:geo_snap/domain/failures/failure.dart';
import 'package:geo_snap/domain/entities/photo_entity.dart';
import 'package:geo_snap/core/services/connectivity_service.dart';
import 'package:geo_snap/core/utils/adapters/either_adapter.dart';
import 'package:geo_snap/data/datasources/photo_data_source.dart';
import 'package:geo_snap/domain/repositories/photo_repository.dart';

class PhotoRepositoryImpl implements PhotoRepository {
  final PhotoDataSource localDataSource;
  final ConnectivityService connectivityService;

  PhotoRepositoryImpl({required this.localDataSource, required this.connectivityService});

  @override
  Future<AppEither<Failure, List<PhotoEntity>>> getAllPhotos() async {
    final online = await connectivityService.hasInternet;
    log('Online: $online', name: 'PhotoRepositoryImpl - getAllPhotos');
    return EitherAdapter.attempt(
      () => localDataSource.getAllPhotos(),
      mapError: (error) => EntityNotFoundFailure(error.toString()),
    );
  }

  @override
  Future<AppEither<Failure, PhotoEntity?>> getPhotoById(String id) async {
    final online = await connectivityService.hasInternet;
    log('Online: $online', name: 'PhotoRepositoryImpl - getPhotoById');
    return EitherAdapter.attempt(
      () => localDataSource.getPhotoById(id),
      mapError: (error) => EntityNotFoundFailure(error.toString()),
    );
  }

  @override
  Future<AppEither<Failure, void>> savePhoto(PhotoEntity entity) async {
    final online = await connectivityService.hasInternet;
    log('Online: $online', name: 'PhotoRepositoryImpl - savePhoto');
    return EitherAdapter.attempt(
      () => localDataSource.savePhoto(entity),
      mapError: (error) => DatabaseFailure(error.toString()),
    );
  }
}
