part of 'photo_bloc.dart';

sealed class PhotoState extends Equatable {
  const PhotoState();
  
  @override
  List<Object> get props => [];
}

final class PhotoInitial extends PhotoState {}

final class PhotoLoading extends PhotoState {}

final class PhotoSuccess extends PhotoState {}

final class PhotoError extends PhotoState {
  final String error;

  const PhotoError(this.error);

  @override
  List<Object> get props => [error];
}

final class PhotoLoaded extends PhotoState {
  final List<PhotoEntity> photos;

  const PhotoLoaded(this.photos);
}

final class PhotoDetailLoaded extends PhotoState {
  final PhotoEntity photo;

  const PhotoDetailLoaded(this.photo);

  @override
  List<Object> get props => [photo];
}

final class PhotoEmpty extends PhotoState {}
  
