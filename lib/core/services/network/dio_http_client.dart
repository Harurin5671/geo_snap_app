import 'package:dio/dio.dart';

import 'package:geo_snap/config/env.dart';
import 'package:geo_snap/config/constants.dart';
import 'package:geo_snap/domain/failures/failure.dart';
import 'package:geo_snap/core/utils/adapters/either_adapter.dart';
import 'package:geo_snap/core/services/network/network_client.dart';

class DioNetworkClient implements NetworkClient {
  final Dio _dio;
  final String _baseUrl;

  DioNetworkClient({String? baseUrl, Dio? dio})
    : _baseUrl = baseUrl ?? Env.baseUrl,
      _dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: baseUrl ?? Env.baseUrl,
              connectTimeout: const Duration(
                milliseconds: AppConstants.connectionTimeout,
              ),
              receiveTimeout: const Duration(
                milliseconds: AppConstants.receiveTimeout,
              ),
            ),
          ) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          handler.next(options);
        },
      ),
    );
  }

  String _resolveUrl(String path, String? overrideBaseUrl) {
    final base = overrideBaseUrl ?? _baseUrl;
    return Uri.parse(base).resolve(path).toString();
  }

  @override
  Future<AppEither<Failure, T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    String? overrideBaseUrl,
    Parser<T>? parser,
  }) => EitherAdapter.attempt(() async {
    final url = _resolveUrl(path, overrideBaseUrl);
    final res = await _dio.delete(
      url,
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
    final raw = res.data;
    return parser != null ? parser(raw) : raw as T;
  }, mapError: _mapError);

  @override
  Future<AppEither<Failure, T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    String? overrideBaseUrl,
    Parser<T>? parser,
  }) => EitherAdapter.attempt<T>(() async {
    final url = _resolveUrl(path, overrideBaseUrl);
    final res = await _dio.get(
      url,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
    final data = res.data;
    return parser != null ? parser(data) : data as T;
  }, mapError: _mapError);

  @override
  Future<AppEither<Failure, T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    String? overrideBaseUrl,
    Parser<T>? parser,
  }) => EitherAdapter.attempt(() async {
    final url = _resolveUrl(path, overrideBaseUrl);
    final res = await _dio.patch(
      url,
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
    final raw = res.data;
    return parser != null ? parser(raw) : raw as T;
  }, mapError: _mapError);

  @override
  Future<AppEither<Failure, T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    String? overrideBaseUrl,
    Parser<T>? parser,
  }) => EitherAdapter.attempt(() async {
    final url = _resolveUrl(path, overrideBaseUrl);
    final res = await _dio.post(
      url,
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
    final raw = res.data;
    return parser != null ? parser(raw) : raw as T;
  }, mapError: _mapError);

  @override
  Future<AppEither<Failure, T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    String? overrideBaseUrl,
    Parser<T>? parser,
  }) => EitherAdapter.attempt(() async {
    final url = _resolveUrl(path, overrideBaseUrl);
    final res = await _dio.put(
      url,
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
    final raw = res.data;
    return parser != null ? parser(raw) : raw as T;
  }, mapError: _mapError);

  Failure _mapError(Object err) {
    if (err is DioException) {
      switch (err.type) {
        case DioExceptionType.connectionTimeout:
          return NetworkFailure(
            'Timeout Connection',
            errorCode: err.type.index,
          );
        case DioExceptionType.sendTimeout:
          return NetworkFailure('Send timeout', errorCode: err.type.index);
        case DioExceptionType.receiveTimeout:
          return NetworkFailure('Receive timeout', errorCode: err.type.index);
        case DioExceptionType.badResponse:
          return ApiFailure(
            'Bad response',
            statusCode: err.response?.statusCode,
            responseData: err.response?.data,
          );
        case DioExceptionType.cancel:
          return NetworkFailure('Request cancelled', errorCode: err.type.index);
        case DioExceptionType.badCertificate:
          return NetworkFailure('Bad certificate', errorCode: err.type.index);
        case DioExceptionType.connectionError:
          return NetworkFailure('Connection error', errorCode: err.type.index);
        case DioExceptionType.unknown:
          return NetworkFailure('Unknown error', errorCode: err.type.index);
      }
    }
    return NetworkFailure('Unknown error', errorCode: -1);
  }
}
