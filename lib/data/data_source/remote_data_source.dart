import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/hospital_model.dart';

class RemoteDataSource {
  final String apiKey;

  RemoteDataSource(this.apiKey);

  Future<List<HospitalModel>> fetchNearbyHospitals(double latitude, double longitude) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latitude,$longitude&radius=10000&type=hospital&key=$apiKey');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Add logging to see the response
        print('API Response: ${response.body}');

        if (data['status'] == 'OK') {
          final hospitals = data['results'] as List;
          return hospitals.map((json) => HospitalModel.fromJson(json)).toList();
        } else {
          // Handle API errors
          print('API Error: ${data['status']} - ${data['error_message']}');
          return [];
        }
      } else {
        print('HTTP Error: ${response.statusCode}');
        throw Exception('Failed to load nearby hospitals');
      }
    } catch (e) {
      print('Exception: $e');
      throw Exception('Failed to load nearby hospitals');
    }
  }
}
