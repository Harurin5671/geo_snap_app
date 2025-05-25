import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

class PhotoPreviewData extends Equatable {
  final XFile photo;
  final Position position;

  const PhotoPreviewData({required this.photo, required this.position});

  @override
  List<Object?> get props => [photo, position];
}