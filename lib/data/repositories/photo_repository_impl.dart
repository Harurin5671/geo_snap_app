import 'package:geo_snap/domain/failures/failure.dart';
import 'package:geo_snap/domain/entities/photo_entity.dart';
import 'package:geo_snap/core/utils/adapters/either_adapter.dart';
import 'package:geo_snap/data/datasources/photo_data_source.dart';
import 'package:geo_snap/domain/repositories/photo_repository.dart';

class PhotoRepositoryImpl implements PhotoRepository {
  final PhotoDataSource localDataSource;

  PhotoRepositoryImpl(this.localDataSource);

  @override
  Future<AppEither<Failure, List<PhotoEntity>>> getAllPhotos() {
    return EitherAdapter.attempt(
      () => localDataSource.getAllPhotos(),
      mapError: (error) => EntityNotFoundFailure(error.toString()),
    );
  }

  @override
  Future<AppEither<Failure, PhotoEntity?>> getPhotoById(String id) {
    return EitherAdapter.attempt(
      () => localDataSource.getPhotoById(id),
      mapError: (error) => EntityNotFoundFailure(error.toString()),
    );
  }

  @override
  Future<AppEither<Failure, void>> savePhoto(PhotoEntity entity) {
    return EitherAdapter.attempt(
      () => localDataSource.savePhoto(entity),
      mapError: (error) => DatabaseFailure(error.toString()),
    );
  }
}
