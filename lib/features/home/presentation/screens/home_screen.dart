import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get_it/get_it.dart';
import '../../../../shared/services/location_service.dart'; // Ajusta path
import '../../../../shared/services/map_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final locationService = GetIt.instance<LocationService>();
  final mapService = GetIt.instance<MapService>();
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vayben - Movilidad Segura')),
      body: Center(
        child: GoogleMap(
          // Integra mapa
          onMapCreated: _onMapCreated,
          initialCameraPosition: const CameraPosition(
            target: LatLng(0.813, -77.717), // Tulcán
            zoom: 14.0,
          ),
        ),
      ),
    );
  }
}
