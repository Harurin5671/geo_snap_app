import 'package:geo_snap/domain/entities/photo_entity.dart';
import 'package:geo_snap/data/mappers/photo_entity_mapper.dart';
import 'package:geo_snap/data/datasources/photo_data_source.dart';
import 'package:geo_snap/data/local/database/daos/photo_dao.dart';

class PhotoLocalDataSource implements PhotoDataSource {
  final PhotoDao dao;

  PhotoLocalDataSource(this.dao);

  @override
  Future<List<PhotoEntity>> getAllPhotos() async {
    final rows = await dao.getAllPhotos();
    return rows.map((row) => PhotoEntityMapper.fromDrift(row)).toList();
  }

  @override
  Future<PhotoEntity?> getPhotoById(String id) async {
    final entry = await dao.getPhotoById(id);
    if (entry == null) return null;
    return PhotoEntityMapper.fromDrift(entry);
  }

  @override
  Future<void> savePhoto(PhotoEntity entity) async {
    await dao.insertPhoto(PhotoEntityMapper.toDrift(entity));
  }
}
