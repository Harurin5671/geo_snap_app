import 'package:geo_snap/domain/failures/failure.dart';
import 'package:geo_snap/domain/entities/photo_entity.dart';
import 'package:geo_snap/core/utils/adapters/either_adapter.dart';

abstract class PhotoRepository {
  Future<AppEither<Failure, void>> savePhoto(PhotoEntity entity);
  Future<AppEither<Failure, List<PhotoEntity>>> getAllPhotos();
  Future<AppEither<Failure, PhotoEntity?>> getPhotoById(String id);
}