import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:geo_snap/application/connectivity/enums/network_status.dart';
import 'package:geo_snap/core/services/connectivity_service.dart';

part 'app_init_event.dart';
part 'app_init_state.dart';

class AppInitBloc extends Bloc<AppInitEvent, AppInitState> {
  final ConnectivityService _connectivityService;
  StreamSubscription? _connectivitySubscription;

  AppInitBloc(this._connectivityService) : super(AppInitInitial()) {
    on<AppInitStartedEvent>(_onStarted);
    on<AppInitConnectivityChangedEvent>(_onConnectivityChanged);

    add(AppInitStartedEvent());
  }

  Future<void> _onStarted(
    AppInitStartedEvent event,
    Emitter<AppInitState> emit,
  ) async {
    emit(AppInitLoading());
    final hasInternet = await _connectivityService.hasInternet;
    if (!hasInternet) {
      emit(AppInitOffline());
      return;
    }
    _connectivitySubscription = _connectivityService.statusStream.listen(
      (status) => add(AppInitConnectivityChangedEvent(status)),
    );
    emit(AppInitSuccess());
  }

  Future<void> _onConnectivityChanged(
    AppInitConnectivityChangedEvent event,
    Emitter<AppInitState> emit,
  ) async {
    switch (event.status) {
      case NetworkStatus.online:
        emit(AppInitSuccess());
        break;
      case NetworkStatus.offline:
        emit(AppInitOffline());
        break;
    }
  }

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    return super.close();
  }
}
