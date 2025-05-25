import 'package:drift/drift.dart';

import 'package:geo_snap/domain/entities/photo_entity.dart';
import 'package:geo_snap/data/local/database/geo_snap_database.dart';

class PhotoEntityMapper {
  /// Map a [PhotoEntry] to a [PhotoEntity]
  static PhotoEntity fromDrift(PhotoEntry data) {
    return PhotoEntity(
      id: data.id,
      path: data.path,
      latitude: data.latitude,
      longitude: data.longitude,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
      deletedAt: data.deletedAt,
    );
  }

  /// Map a [PhotoEntity] to a [PhotoEntry]
  static PhotoEntriesCompanion toDrift(PhotoEntity entity) {
    return PhotoEntriesCompanion(
      id: Value(entity.id),
      path: Value(entity.path),
      latitude: Value(entity.latitude),
      longitude: Value(entity.longitude),
      createdAt: Value(entity.createdAt),
      updatedAt: Value(entity.updatedAt),
      deletedAt: Value(entity.deletedAt),
    );
  }
}