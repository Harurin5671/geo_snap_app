import 'package:geo_snap/domain/entities/photo_entity.dart';

abstract class PhotoDataSource {
  Future<void> savePhoto(PhotoEntity entity);
  Future<List<PhotoEntity>> getAllPhotos();
  Future<PhotoEntity?> getPhotoById(String id);
}
