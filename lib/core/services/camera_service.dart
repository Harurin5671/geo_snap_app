import 'package:camera/camera.dart';

import 'permission_service.dart';

class CameraService {
  final PermissionService _permissionService;
  CameraController? _controller;

  CameraService(this._permissionService);

  Future<CameraController?> initializeCamera() async {
    final granted = await _permissionService.requestCameraPermission();
    if (!granted) return null;

    final cameras = await availableCameras();
    final camera = cameras.first;
    _controller = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
    );
    await _controller!.initialize();
    return _controller;
  }

  Future<XFile?> takePicture() async {
    if (_controller == null || !_controller!.value.isInitialized) return null;
    try {
      return await _controller!.takePicture();
    } catch (error) {
      return null;
    }
  }

  void disposeCamera() {
    _controller?.dispose();
  }
}
