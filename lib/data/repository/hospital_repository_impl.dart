// data/repositories/hospital_repository_impl.dart
import 'dart:async';
import '../../domain/entities/hospital.dart';
import '../data_source/remote_data_source.dart';

class HospitalRepository {
  final RemoteDataSource remoteDataSource;

  HospitalRepository(this.remoteDataSource);

  Future<List<Hospital>> getNearbyHospitals(double latitude, double longitude) {
    return remoteDataSource.fetchNearbyHospitals(latitude, longitude);
  }
}
