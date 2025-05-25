part of 'camera_bloc.dart';

sealed class CameraEvent extends Equatable {
  const CameraEvent();

  @override
  List<Object?> get props => [];
}

class CameraStartedEvent extends CameraEvent {}

class TakePhotoWithLocationEvent extends CameraEvent {}

class CameraResetEvent extends CameraEvent {}
  