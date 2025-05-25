import 'package:geo_snap/domain/entities/photo_entity.dart';
import 'package:geo_snap/domain/repositories/photo_repository.dart';

class SavePhotoUseCase {
  final PhotoRepository repository;

  SavePhotoUseCase(this.repository);

  Future<void> call(PhotoEntity photo) async {
    await repository.savePhoto(photo);
  }
} 