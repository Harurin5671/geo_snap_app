import 'package:geo_snap/domain/repositories/photo_repository.dart';
import 'package:geo_snap/application/photo/results/get_all_photos_result.dart';

class GetAllPhotosUseCase {
  final PhotoRepository repository;

  GetAllPhotosUseCase(this.repository);

  Future<GetAllPhotosResult> call() async {
    final photos = await repository.getAllPhotos();
    if (photos.isEmpty) {
      return NotPhotosFound();
    }
    return PhotosFound(photos);
  }
}
