import 'package:geo_snap/application/photo/results/get_photo_by_id_result.dart';
import 'package:geo_snap/domain/repositories/photo_repository.dart';

class GetPhotoByIdUseCase {
  final PhotoRepository repository;

  GetPhotoByIdUseCase(this.repository);

  Future<GetPhotoByIdResult> call(String id) async {
    final photo = await repository.getPhotoById(id);
    if (photo == null) {
      return PhotoNotFound();
    }
    return PhotoFound(photo);
  }
}
