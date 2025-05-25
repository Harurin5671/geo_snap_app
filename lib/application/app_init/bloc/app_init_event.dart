part of 'app_init_bloc.dart';

sealed class AppInitEvent extends Equatable {
  const AppInitEvent();

  @override
  List<Object> get props => [];
}

final class AppInitStartedEvent extends AppInitEvent {}

final class AppInitConnectivityChangedEvent extends AppInitEvent {
  final NetworkStatus status;

  const AppInitConnectivityChangedEvent(this.status);

  @override
  List<Object> get props => [status];
}
