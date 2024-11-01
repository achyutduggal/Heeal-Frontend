import 'dart:async';
import '../../data/repository/hospital_repository_impl.dart';
import '../entities/hospital.dart';

class GetNearbyHospitalsUseCase {
  final HospitalRepository repository;

  GetNearbyHospitalsUseCase(this.repository);

  Future<List<Hospital>> execute(double latitude, double longitude) {
    return repository.getNearbyHospitals(latitude, longitude);
  }
}
