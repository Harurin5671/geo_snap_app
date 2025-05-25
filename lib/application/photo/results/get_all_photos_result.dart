import 'package:geo_snap/domain/entities/photo_entity.dart';

sealed class GetAllPhotosResult {}

final class PhotosFound extends GetAllPhotosResult {
  final List<PhotoEntity> photos;

  PhotosFound(this.photos);
}

class NotPhotosFound extends GetAllPhotosResult {}