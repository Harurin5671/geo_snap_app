import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:geo_snap/domain/failures/failure.dart';
import 'package:geo_snap/domain/entities/entities.dart';
import 'package:geo_snap/application/photo/results/results.dart';
import 'package:geo_snap/application/photo/usecases/usecases.dart';

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

    final either = await savePhotoUseCase.call(event.photo);

    either.fold(
      (failure) {
        if (failure is DatabaseFailure) {
          emit(PhotoError('Database error'));
        } else {
          emit(PhotoError(failure.message));
        }
      },
      (_) => emit(PhotoSuccess()),
    );
  }

  Future<void> _onLoadPhotos(
    LoadPhotosEvent event,
    Emitter<PhotoState> emit,
  ) async {
    emit(PhotoLoading());

    final either = await getAllPhotosUseCase.call();

    either.fold(
      (failure) {
        if (failure is EntityNotFoundFailure) {
          emit(PhotoEmpty());
        } else {
          emit(PhotoError(failure.message));
        }
      },
      (result) {
        if (result is PhotosFound) {
          emit(PhotoLoaded(result.photos));
        } else {
          emit(PhotoEmpty());
        }
      },
    );
  }

  Future<void> _onLoadPhotoById(
    LoadPhotoByIdEvent event,
    Emitter<PhotoState> emit,
  ) async {
    emit(PhotoLoading());

    final either = await getPhotoByIdUseCase.call(event.photoId);

    either.fold(
      (failure) {
        if (failure is EntityNotFoundFailure) {
          emit(PhotoError('Photo not found'));
        } else {
          emit(PhotoError(failure.message));
        }
      },
      (result) {
        if (result is PhotoFound) {
          emit(PhotoDetailLoaded(result.photo));
        } else {
          emit(PhotoError('Photo not found'));
        }
      },
    );
  }
}
