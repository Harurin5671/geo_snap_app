part of 'photo_bloc.dart';

sealed class PhotoEvent extends Equatable {
  const PhotoEvent();

  @override
  List<Object?> get props => [];
}

final class SavePhotoEvent extends PhotoEvent {
  final PhotoEntity photo;

  const SavePhotoEvent(this.photo);

  @override
  List<Object?> get props => [photo];
}

final class UpdatePhotoEvent extends PhotoEvent {
  final PhotoEntity entity;

  const UpdatePhotoEvent(this.entity);

  @override
  List<Object?> get props => [entity];
}

final class DeletePhotoEvent extends PhotoEvent {
  final String photoId;

  const DeletePhotoEvent(this.photoId);

  @override
  List<Object?> get props => [photoId];
}

final class LoadPhotosEvent extends PhotoEvent {}

final class LoadPhotoByIdEvent extends PhotoEvent {
  final String photoId;

  const LoadPhotoByIdEvent(this.photoId);

  @override
  List<Object?> get props => [photoId];
}
