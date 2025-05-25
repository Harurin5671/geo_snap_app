import 'package:geo_snap/domain/entities/photo_entity.dart';
import 'package:geo_snap/data/datasources/photo_data_source.dart';
import 'package:geo_snap/domain/repositories/photo_repository.dart';

class PhotoRepositoryImpl implements PhotoRepository {
  final PhotoDataSource localDataSource;

  PhotoRepositoryImpl(this.localDataSource);

  @override
  Future<List<PhotoEntity>> getAllPhotos() => localDataSource.getAllPhotos();

  @override
  Future<PhotoEntity?> getPhotoById(String id) =>
      localDataSource.getPhotoById(id);

  @override
  Future<void> savePhoto(PhotoEntity entity) =>
      localDataSource.savePhoto(entity);
}
