part of 'camera_bloc.dart';

sealed class CameraEvent extends Equatable {
  const CameraEvent();

  @override
  List<Object?> get props => [];
}

final class CameraStartedEvent extends CameraEvent {}

final class TakePhotoWithLocationEvent extends CameraEvent {}

final class SwitchCameraEvent extends CameraEvent {}

final class CameraResetEvent extends CameraEvent {}
