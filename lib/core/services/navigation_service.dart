import 'package:go_router/go_router.dart';

import 'package:geo_snap/config/app_router.dart';

class NavigationService {
  final GoRouter _router;

  NavigationService({GoRouter? router}) : _router = router ?? appRouter;

  /// Navigate using name of the route
  Future<void> pushNamed(
    String routeName, {
    Map<String, String>? parameters,
    Map<String, String>? queryParameters,
    Object? extra,
  }) async {
    await _router.pushNamed(
      routeName,
      pathParameters: parameters ?? {},
      queryParameters: queryParameters ?? {},
      extra: extra,
    );
  }

  /// Navigate using path of the route
  void pushRoute(String routePath, {Object? extra}) async {
    await _router.push(routePath, extra: extra);
  }

  /// Navigate and replace the current route with name
  void goNamed(
    String routeName, {
    Map<String, String>? parameters,
    Map<String, String>? queryParameters,
    Object? extra,
  }) {
    _router.goNamed(
      routeName,
      pathParameters: parameters ?? {},
      queryParameters: queryParameters ?? {},
      extra: extra,
    );
  }

  /// Navigate and replace the current route with path
  void goRoute(String routePath, {Object? extra}) async {
    await _router.pushReplacement(routePath, extra: extra);
  }

  /// Navigate back to previous route
  void goBack() {
    if (_router.canPop()) {
      _router.pop();
    }
  }
}
