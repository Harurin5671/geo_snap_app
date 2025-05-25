part of 'camera_bloc.dart';

sealed class CameraState extends Equatable {
  const CameraState();
  
  @override
  List<Object?> get props => [];
}

final class CameraInitial extends CameraState {}

final class CameraLoading extends CameraState {}

final class CameraReady extends CameraState {
  final CameraController controller;

  const CameraReady({required this.controller});

  @override
  List<Object?> get props => [controller];
}

final class CameraCaptureInProgress extends CameraState {}

final class CameraCaptureSuccess extends CameraState {
  final XFile photo;
  final Position position;

  const CameraCaptureSuccess(this.photo, this.position);

  @override
  List<Object?> get props => [photo, position];
}

class CameraFailure extends CameraState {
  final String message;

  const CameraFailure(this.message);

  @override
  List<Object?> get props => [message];
}
