import 'package:geo_snap/domain/entities/photo_entity.dart';

sealed class GetPhotoByIdResult {}

final class PhotoFound extends GetPhotoByIdResult {
  final PhotoEntity photo;

  PhotoFound(this.photo);
}

final class PhotoNotFound extends GetPhotoByIdResult {}
