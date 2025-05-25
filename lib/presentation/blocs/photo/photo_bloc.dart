import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:geo_snap/domain/entities/photo_entity.dart';
import 'package:geo_snap/domain/repositories/photo_repository.dart';

part 'photo_event.dart';
part 'photo_state.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final PhotoRepository photoRepository;
  PhotoBloc({required this.photoRepository}) : super(PhotoInitial()) {
    on<SavePhotoEvent>(_onSavePhoto);
    on<LoadPhotosEvent>(_onLoadPhotos);
    on<LoadPhotoByIdEvent>(_onLoadPhotoById);
  }

  Future<void> _onSavePhoto(
    SavePhotoEvent event,
    Emitter<PhotoState> emit,
  ) async {
    emit(PhotoLoading());
    try {
      await photoRepository.savePhoto(event.photo);
      emit(PhotoSuccess());
    } catch (error) {
      emit(PhotoError(error.toString()));
    }
  }

  Future<void> _onLoadPhotos(
    LoadPhotosEvent event,
    Emitter<PhotoState> emit,
  ) async {
    emit(PhotoLoading());
    try {
      final photos = await photoRepository.getAllPhotos();
      if (photos.isEmpty) {
        emit(PhotoEmpty());
        return;
      }
      emit(PhotoLoaded(photos));
    } catch (error) {
      emit(PhotoError(error.toString()));
    }
  }

  Future<void> _onLoadPhotoById(
    LoadPhotoByIdEvent event,
    Emitter<PhotoState> emit,
  ) async {
    emit(PhotoLoading());
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      final photo = await photoRepository.getPhotoById(event.photoId);
      if (photo == null) {
        emit(PhotoError('Photo not found'));
        return;
      }
      emit(PhotoDetailLoaded(photo));
    } catch (error) {
      emit(PhotoError(error.toString()));
    }
  }
}
