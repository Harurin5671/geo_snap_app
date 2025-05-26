import 'package:camera/camera.dart';

import 'permission_service.dart';

class CameraService {
  final PermissionService _permissionService;                      
  CameraController? _controller;
  List<CameraDescription> _cameras = [];
  int _selectedCameraIndex = 0;

  CameraService(this._permissionService);

  Future<CameraController?> initializeCamera() async {
    final granted = await _permissionService.requestCameraPermission();
    if (!granted) return null;

    _cameras = await availableCameras();
    if(_cameras.isEmpty) return null;
    
    final camera = _cameras[_selectedCameraIndex];
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

  Future<CameraController?> switchCamera() async {
    if (_cameras.length < 2) return _controller;
    _selectedCameraIndex = (_selectedCameraIndex + 1) % _cameras.length;
    await _controller?.dispose();
    final newCamera = _cameras[_selectedCameraIndex];
    _controller = CameraController(
      newCamera,
      ResolutionPreset.high,
      enableAudio: false,
    );
    await _controller!.initialize();
    return _controller;
  }

  CameraController? get controller => _controller;

  void disposeCamera() {
    _controller?.dispose();
  }
}
