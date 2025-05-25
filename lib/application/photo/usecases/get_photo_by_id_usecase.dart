import 'package:geo_snap/domain/failures/failure.dart';
import 'package:geo_snap/core/utils/adapters/either_adapter.dart';
import 'package:geo_snap/domain/repositories/photo_repository.dart';
import 'package:geo_snap/application/photo/results/get_photo_by_id_result.dart';

class GetPhotoByIdUseCase {
  final PhotoRepository repository;

  GetPhotoByIdUseCase(this.repository);

  Future<AppEither<Failure, GetPhotoByIdResult>> call(String id) async {
    final photo = await repository.getPhotoById(id);
    return photo.fold(
      (failure) => EitherAdapter.left(failure),
      (photo) {
        if (photo == null) {
          return EitherAdapter.left(EntityNotFoundFailure('Photo not found'));
        }
        return EitherAdapter.right(PhotoFound(photo));
      },
    );
  }
}
