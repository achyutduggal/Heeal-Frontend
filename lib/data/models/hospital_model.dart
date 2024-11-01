import '../../domain/entities/hospital.dart';

class HospitalModel extends Hospital {
  HospitalModel({
    required String name,
    required double latitude,
    required double longitude,
  }) : super(name: name, latitude: latitude, longitude: longitude);

  factory HospitalModel.fromJson(Map<String, dynamic> json) {
    return HospitalModel(
      name: json['name'],
      latitude: json['geometry']['location']['lat']?.toDouble() ?? 0.0,
      longitude: json['geometry']['location']['lng']?.toDouble() ?? 0.0,
    );
  }
}
