part of 'app_init_bloc.dart';

sealed class AppInitState extends Equatable {
  const AppInitState();

  @override
  List<Object?> get props => [];
}

final class AppInitInitial extends AppInitState {}

final class AppInitLoading extends AppInitState {}

final class AppInitSuccess extends AppInitState {}

final class AppInitOffline extends AppInitState {}

final class AppInitFailure extends AppInitState {
  final String message;

  const AppInitFailure(this.message);

  @override
  List<Object?> get props => [message];
}
