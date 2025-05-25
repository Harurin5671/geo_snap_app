import 'package:dartz/dartz.dart';
import 'package:geo_snap/domain/failures/failure.dart';

typedef AppEither<L, R> = Either<L, R>;

class EitherAdapter {
  static AppEither<L, R> left<L, R>(L left) => Left(left);
  static AppEither<L, R> right<L, R>(R right) => Right(right);

  static T fold<L, R, T>(
    AppEither<L, R> either,
    T Function(L left) ifLeft,
    T Function(R right) ifRight,
  ) {
    return either.fold(ifLeft, ifRight);
  }

  static Future<AppEither<Failure, R>> attempt<R>(
    Future<R> Function() action, {
    Failure Function(Object error)? mapError,
  }) async {
    try {
      final r = await action();
      return Right(r);
    } catch (e) {
      final f = mapError?.call(e) ?? UnexpectedFailure(e.toString());
      return Left(f);
    }
  }
}
