import 'package:geolocator/geolocator.dart';

import 'permission_service.dart';

class LocationService {
  final PermissionService _permissionService;

  LocationService(this._permissionService);

  Future<Position?> getCurrentPosition() async {
    final granted = await _permissionService.isLocationPermissionGranted();
    if (!granted) {
      final granted = await _permissionService.requestLocationPermission();
      if (!granted) return null;
    }
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.best),
    );
    return position;
  }
}
