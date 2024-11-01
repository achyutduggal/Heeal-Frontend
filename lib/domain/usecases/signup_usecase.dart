import 'package:dartz/dartz.dart';
import '../../data/network/failure.dart';

class SignupUseCase {
  Future<Either<Failure, bool>> execute(String email, String password) async {
    return Right(true); // Mocked response, return success
  }
}