import 'package:geo_snap/domain/failures/failure.dart';
import 'package:geo_snap/domain/entities/photo_entity.dart';
import 'package:geo_snap/core/utils/adapters/either_adapter.dart';
import 'package:geo_snap/domain/repositories/photo_repository.dart';

class SavePhotoUseCase {
  final PhotoRepository repository;

  SavePhotoUseCase(this.repository);

   Future<AppEither<Failure, void>> call(PhotoEntity photo) async {
    try {
      await repository.savePhoto(photo);
      return EitherAdapter.right(null);
    } catch (e) {
      return EitherAdapter.left(DatabaseFailure(e.toString()));
    }
  }
} 