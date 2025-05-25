import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }

  Future<bool> requestLocationPermission() async {
    final status = await Permission.locationWhenInUse.request();
    return status.isGranted;
  }

  // Validation
  Future<bool> isCameraPermissionGranted() async {
    final status = await Permission.camera.isGranted;
    return status;
  }

  Future<bool> isLocationPermissionGranted() async {
    final status = await Permission.locationWhenInUse.isGranted;
    return status;
  }
}
