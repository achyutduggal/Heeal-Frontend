// domain/failure.dart
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

// General Failures
class ServerFailure extends Failure {
  const ServerFailure([String message = "Server error occurred"]) : super(message);
}

class CacheFailure extends Failure {
  const CacheFailure([String message = "Cache error occurred"]) : super(message);
}

class NetworkFailure extends Failure {
  const NetworkFailure([String message = "Network error occurred"]) : super(message);
}

class AuthenticationFailure extends Failure {
  const AuthenticationFailure([String message = "Authentication failed"]) : super(message);
}

// Validation Failure for input validation errors
class ValidationFailure extends Failure {
  const ValidationFailure([String message = "Invalid input"]) : super(message);
}

// Other Failure Types can be added here
