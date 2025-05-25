import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:geo_snap/application/connectivity/enums/network_status.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectivityService {
  final _connectivity = Connectivity();
  final _checker = InternetConnectionChecker.createInstance();

  Stream<NetworkStatus> get statusStream =>
      _connectivity.onConnectivityChanged.asyncMap((conn) async {
        log('[ConnectivityService] Status network: $conn');
        if (conn.contains(ConnectivityResult.none)) {
          log('[ConnectivityService] Status network: offline');
          return NetworkStatus.offline;
        }
        final hasConnection = await _checker.hasConnection;
         log('[InternetConnectionChecker] Conexión real: $hasConnection');

         final status = hasConnection ? NetworkStatus.online : NetworkStatus.offline;
        log('[NetworkStatus] Emitiendo: $status');
        return status;
      });

  Future<bool> get hasInternet async => await _checker.hasConnection;
}
