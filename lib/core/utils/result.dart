import 'package:equatable/equatable.dart';

import 'package:geo_snap/domain/failures/failure.dart';

sealed class Result<T> extends Equatable {
  const Result();

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is ErrorResult<T>;

  T get value {
    if (this is Success<T>) return (this as Success<T>).value;
    throw StateError('No hay valor: $this');
  }

  T? get valueOrNull => this is Success<T> ? (this as Success<T>).value : null;

  Failure get error {
    if (this is ErrorResult<T>) return (this as ErrorResult<T>).failure;
    throw StateError('No hay error en un Success: $this');
  }

  R fold<R>({
    required R Function(T value) onSuccess,
    required R Function(Failure failure) onFailure,
  }) {
    return isSuccess
      ? onSuccess((this as Success<T>).value)
      : onFailure((this as ErrorResult<T>).failure);
  }

  @override
  String toString() => isSuccess
    ? 'Success(${(this as Success<T>).value})'
    : 'ErrorResult(${(this as ErrorResult<T>).failure})';

  @override
  List<Object?> get props => [];
}

final class Success<T> extends Result<T> {
  final T value;
  const Success(this.value);

  @override
  List<Object?> get props => [value];
}

final class ErrorResult<T> extends Result<T> {
  final Failure failure;
  const ErrorResult(this.failure);

  @override
  List<Object?> get props => [failure];
}
