import 'package:uuid/uuid.dart';
import 'package:equatable/equatable.dart';

class PhotoEntity extends Equatable {
  final String id;
  final String path;
  final double latitude;
  final double longitude;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  const PhotoEntity({
    required this.id,
    required this.path,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  /// Factory constructor to create a [PhotoEntity] from a [Map]
  factory PhotoEntity.newEntry({
    required String path,
    required double latitude,
    required double longitude,
  }) {
    return PhotoEntity(
      id: const Uuid().v4(),
      path: path,
      latitude: latitude,
      longitude: longitude,
      createdAt: DateTime.now(),
      updatedAt: null,
      deletedAt: null,
    );
  }

  @override
  List<Object?> get props => [
    id,
    path,
    latitude,
    longitude,
    createdAt,
    updatedAt,
    deletedAt,
  ];
}
