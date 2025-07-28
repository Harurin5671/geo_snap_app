import 'package:geo_snap/domain/failures/failure.dart';
import 'package:geo_snap/core/utils/adapters/either_adapter.dart';

typedef Parser<T> = T Function(dynamic data);

abstract class NetworkClient {
  Future<AppEither<Failure, T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    String? overrideBaseUrl,
    Parser<T>? parser,
  });

  Future<AppEither<Failure, T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    String? overrideBaseUrl,
    Parser<T>? parser,
  });

  Future<AppEither<Failure, T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    String? overrideBaseUrl,
    Parser<T>? parser,
  });

  Future<AppEither<Failure, T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    String? overrideBaseUrl,
    Parser<T>? parser,
  });

  Future<AppEither<Failure, T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    String? overrideBaseUrl,
    Parser<T>? parser,
  });
}
