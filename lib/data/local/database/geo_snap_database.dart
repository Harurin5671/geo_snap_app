import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;

import 'package:path_provider/path_provider.dart';
import 'package:geo_snap/data/local/database/daos/photo_dao.dart';
import 'package:geo_snap/data/local/database/tables/photo_entries.dart';

part 'geo_snap_database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'geo_snap_db.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(
  tables: [PhotoEntries],
  daos: [PhotoDao]
)
class GeoSnapDatabase extends _$GeoSnapDatabase {
  GeoSnapDatabase() : super(_openConnection());
  @override
  int get schemaVersion => 1;
}