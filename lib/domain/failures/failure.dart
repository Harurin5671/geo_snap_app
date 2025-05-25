import 'package:equatable/equatable.dart';

/// Error al leer o escribir en la base de datos local
final class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message);
}

/// Cuando no existe la entidad buscada (por ejemplo, foto con ese id)
final class EntityNotFoundFailure extends Failure {
  const EntityNotFoundFailure(super.message);
}

/// Cuando un valor inesperado es `null` (p. ej. un campo obligatorio viene vacío)
final class NullValueFailure extends Failure {
  const NullValueFailure(super.message);
}

/// Errores de conectividad de red
final class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

/// Cualquier otro error imprevisto
final class UnexpectedFailure extends Failure {
  const UnexpectedFailure(super.message);
}

/// Base común a todos los errores
abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}
