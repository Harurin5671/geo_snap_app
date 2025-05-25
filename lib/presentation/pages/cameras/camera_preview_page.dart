import 'package:flutter/material.dart';

import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:geo_snap/config/route_constants.dart';
import 'package:geo_snap/core/services/navigation_service.dart';
import 'package:geo_snap/presentation/blocs/camera/camera_bloc.dart';
import 'package:geo_snap/presentation/models/photo_preview_data.dart';

class CameraPreviewPage extends StatelessWidget {
  const CameraPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CameraBloc, CameraState>(
        listenWhen: (previous, current) => current is CameraCaptureSuccess,
        listener: (context, state) async {
          if (state is CameraCaptureSuccess) {
            context.read<CameraBloc>().add(CameraResetEvent());
            final previewData = PhotoPreviewData(
              photo: state.photo,
              position: state.position,
            );
            await NavigationService().pushNamed(
              RouteNames.cameraPreview,
              extra: previewData,
            );
          }
        },
        builder: (context, state) {
          if (state is CameraLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CameraReady) {
            return Stack(
              fit: StackFit.expand,
              children: [
                CameraPreview(state.controller),
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: FloatingActionButton(
                      onPressed: () {
                        context.read<CameraBloc>().add(
                          TakePhotoWithLocationEvent(),
                        );
                      },
                      child: const Icon(Icons.camera_alt, size: 32),
                    ),
                  ),
                ),
              ],
            );
          } else if (state is CameraCaptureInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CameraInitial){
            context.read<CameraBloc>().add(CameraStartedEvent());
          }
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.photo_camera_front,
                  size: 64,
                  color: Colors.grey,
                ),
                const SizedBox(height: 12),
                const Text(
                  "Prepara tu cámara para capturar\nuna nueva foto",
                  style: TextStyle(fontSize: 17, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
