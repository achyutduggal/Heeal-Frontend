import 'package:dartz/dartz.dart';
import '../../data/network/failure.dart';

class LoginUseCase {
  Future<Either<Failure, bool>> execute(String email, String password) async {
    // Here, actual authentication logic or API call can be implemented
    return Right(true); // Mocked response, return success
  }
}