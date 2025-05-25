import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:geo_snap/application/photo/usecases/usecases.dart';
import 'package:geo_snap/application/photo/results/results.dart';
import 'package:geo_snap/domain/entities/entities.dart';

part 'photo_event.dart';
part 'photo_state.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final SavePhotoUseCase savePhotoUseCase;
  final GetAllPhotosUseCase getAllPhotosUseCase;
  final GetPhotoByIdUseCase getPhotoByIdUseCase;

  PhotoBloc({
    required this.savePhotoUseCase,
    required this.getAllPhotosUseCase,
    required this.getPhotoByIdUseCase,
  }) : super(PhotoInitial()) {
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
      await savePhotoUseCase.call(event.photo);
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
      final result = await getAllPhotosUseCase.call();

      switch (result) {
        case NotPhotosFound():
          emit(PhotoEmpty());
          break;
        case PhotosFound():
          emit(PhotoLoaded(result.photos));
          break;
      }
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
      final result = await getPhotoByIdUseCase.call(event.photoId);

      switch (result) {
        case PhotoFound():
          emit(PhotoDetailLoaded(result.photo));
          break;
        case PhotoNotFound():
          emit(PhotoError('Photo not found'));
          break;
      }
    } catch (error) {
      emit(PhotoError(error.toString()));
    }
  }
}
