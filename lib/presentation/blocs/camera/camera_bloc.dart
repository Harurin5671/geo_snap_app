import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:geo_snap/core/services/services.dart';

part 'camera_event.dart';
part 'camera_state.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  final CameraService cameraService;
  final LocationService locationService;

  CameraBloc({required this.cameraService, required this.locationService})
    : super(CameraInitial()) {
    on<CameraStartedEvent>(_onStarted);
    on<TakePhotoWithLocationEvent>(_onTakePhotoWithLocation);
    on<CameraResetEvent>(_onCameraReset);
    
    add(CameraStartedEvent());
  }

  Future<void> _onStarted(
    CameraStartedEvent event,
    Emitter<CameraState> emit,
  ) async {
    emit(CameraLoading());
    final controller = await cameraService.initializeCamera();
    if (controller != null) {
      emit(CameraReady(controller: controller));
    } else {
      emit(const CameraFailure('Failed to initialize camera'));
    }
  }

  Future<void> _onTakePhotoWithLocation(
    TakePhotoWithLocationEvent event,
    Emitter<CameraState> emit,
  ) async {
    emit(CameraCaptureInProgress());
    final Position? position = await locationService.getCurrentPosition();
    final XFile? photo = await cameraService.takePicture();
    if (position != null && photo != null) {
      emit(CameraCaptureSuccess(photo, position));
    } else {
      emit(const CameraFailure('Failed to get current position or take picture'));
    }
  }

  Future<void> _onCameraReset(
    CameraResetEvent event,
    Emitter<CameraState> emit,
  ) async {
    emit(CameraInitial());
  }

  @override
  Future<void> close() {
    cameraService.disposeCamera();
    return super.close();
  }
}
