import 'package:drift/drift.dart';

import 'package:geo_snap/data/local/database/geo_snap_database.dart';
import 'package:geo_snap/data/local/database/tables/photo_entries.dart';

part 'photo_dao.g.dart';

@DriftAccessor(tables: [PhotoEntries])
class PhotoDao extends DatabaseAccessor<GeoSnapDatabase> with _$PhotoDaoMixin {
  PhotoDao(super.db);

  Future<int> insertPhoto(PhotoEntriesCompanion entry) =>
      into(photoEntries).insert(entry);
  Future<List<PhotoEntry>> getAllPhotos() => select(photoEntries).get();
  Future<PhotoEntry?> getPhotoById(String id) {
    return (select(
      photoEntries,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }
}
