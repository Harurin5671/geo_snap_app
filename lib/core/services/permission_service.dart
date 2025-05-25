import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  Future<bool> requestCameraPermission() async {
    final status = await isCameraPermissionGranted();
    if (status) return true;

    final result = await Permission.camera.request();
    return result.isGranted;
  }

  Future<bool> requestLocationPermission() async {
    final status = await isLocationPermissionGranted();
    if (status) return true;

    final result = await Permission.locationWhenInUse.request();
    return result.isGranted;
  }

  // Validation
  Future<bool> isCameraPermissionGranted() async {
    final status = await Permission.camera.status;
    return status.isGranted;
  }

  Future<bool> isLocationPermissionGranted() async {
    final status = await Permission.locationWhenInUse.status;
    return status.isGranted;
  }
}
