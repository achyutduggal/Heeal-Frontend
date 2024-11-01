import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../../data/data_source/remote_data_source.dart';
import '../../data/repository/hospital_repository_impl.dart';
import '../../domain/entities/hospital.dart';
import '../../domain/usecases/get_nearby_hospitals_usecase.dart';

class HospitalView extends StatefulWidget {
  const HospitalView({super.key});

  @override
  State<HospitalView> createState() => _HospitalViewState();
}

class _HospitalViewState extends State<HospitalView> {
  GoogleMapController? _mapController;
  Position? _currentPosition;
  final Set<Marker> _markers = {};
  bool _isLoading = true;
  late GetNearbyHospitalsUseCase _getNearbyHospitalsUseCase;

  @override
  void initState() {
    super.initState();

    final remoteDataSource = RemoteDataSource("");
    final hospitalRepository = HospitalRepository(remoteDataSource);
    _getNearbyHospitalsUseCase = GetNearbyHospitalsUseCase(hospitalRepository);

    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print('Location permissions are permanently denied');
      return;
    }

    try {
      _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      _addUserLocationMarker();
      _fetchNearbyHospitals();
    } catch (e) {
      print('Error getting current location: $e');
    }
  }

  Future<void> _fetchNearbyHospitals() async {
    if (_currentPosition == null) return;

    try {
      final hospitals = await _getNearbyHospitalsUseCase.execute(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
      );

      if (hospitals.isNotEmpty) {
        _addHospitalMarkers(hospitals);
      } else {
        print('No hospitals found nearby.');
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching hospitals: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _addUserLocationMarker() {
    if (_currentPosition == null) return;

    setState(() {
      _markers.add(Marker(
        markerId: const MarkerId("userLocation"),
        position: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: const InfoWindow(title: "Your Location"),
      ));
    });
  }

  void _addHospitalMarkers(List<Hospital> hospitals) {
    setState(() {
      for (var hospital in hospitals) {
        _markers.add(
          Marker(
            markerId: MarkerId(hospital.name),
            position: LatLng(hospital.latitude, hospital.longitude),
            infoWindow: InfoWindow(title: hospital.name),
          ),
        );
      }
      _isLoading = false;

      // Adjust the camera view
      _adjustCameraView();
    });
  }

  void _adjustCameraView() {
    if (_markers.isNotEmpty && _mapController != null) {
      LatLngBounds bounds = _createLatLngBoundsFromMarkers(_markers);
      _mapController!.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
    }
  }

  LatLngBounds _createLatLngBoundsFromMarkers(Set<Marker> markers) {
    if (markers.isEmpty) {
      // Handle the empty markers case
      // Return bounds centered at the user's current position
      return LatLngBounds(
        southwest: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
        northeast: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
      );
    }

    // Initialize x0, x1, y0, y1 with the first marker's position
    final firstMarker = markers.first;
    double x0 = firstMarker.position.latitude;
    double x1 = firstMarker.position.latitude;
    double y0 = firstMarker.position.longitude;
    double y1 = firstMarker.position.longitude;

    // Now iterate over the markers to find the bounds
    for (Marker marker in markers) {
      var lat = marker.position.latitude;
      var lng = marker.position.longitude;

      if (lat > x1) x1 = lat;
      if (lat < x0) x0 = lat;
      if (lng > y1) y1 = lng;
      if (lng < y0) y0 = lng;
    }

    return LatLngBounds(
      southwest: LatLng(x0, y0),
      northeast: LatLng(x1, y1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nearby Hospitals")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
        onMapCreated: (controller) {
          _mapController = controller;
          // Adjust the camera once the map is created
          _adjustCameraView();
        },
        initialCameraPosition: CameraPosition(
          target: _currentPosition != null
              ? LatLng(_currentPosition!.latitude, _currentPosition!.longitude)
              : const LatLng(0.0, 0.0),
          zoom: 14,
        ),
        markers: _markers,
        myLocationEnabled: true,
      ),
    );
  }
}
