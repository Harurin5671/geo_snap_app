import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:geo_snap/core/utils/image_utils.dart';
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
    on<SwitchCameraEvent>(_onSwitchCamera);
    on<CameraResetEvent>(_onCameraReset);

    // add(CameraStartedEvent());
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
      final XFile? annotated = await addMetadataToImage(
        photo.path,
        latitude: position.latitude,
        longitude: position.longitude,
      );
      if (annotated != null) {
        log('📸 Imagen con metadatos: ${annotated.path}');
        emit(CameraCaptureSuccess(annotated, position));
      } else {
        emit(const CameraFailure('No se pudo generar imagen con metadatos'));
      }
    } else {
      emit(
        const CameraFailure('Failed to get current position or take picture'),
      );
    }
  }

  Future<void> _onSwitchCamera(
    SwitchCameraEvent event,
    Emitter<CameraState> emit,
  ) async {
    emit(CameraLoading());
    final controller = await cameraService.switchCamera();
    if (controller != null) {
      emit(CameraReady(controller: controller));
    } else {
      emit(const CameraFailure('No se pudo cambiar de cámara'));
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
