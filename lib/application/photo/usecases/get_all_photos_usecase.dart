import 'package:geo_snap/domain/failures/failure.dart';
import 'package:geo_snap/core/utils/adapters/either_adapter.dart';
import 'package:geo_snap/domain/repositories/photo_repository.dart';
import 'package:geo_snap/application/photo/results/get_all_photos_result.dart';

class GetAllPhotosUseCase {
  final PhotoRepository repository;

  GetAllPhotosUseCase(this.repository);

  Future<AppEither<Failure, GetAllPhotosResult>> call() async {
    final either = await repository.getAllPhotos();

    return either.fold(
      (failure) => EitherAdapter.left(failure),
      (photos) {
        if (photos.isEmpty) {
          return EitherAdapter.left(EntityNotFoundFailure('No photos found'));
        }
        return EitherAdapter.right(PhotosFound(photos));
      },
    );
  }
}
