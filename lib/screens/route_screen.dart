import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class RouteScreen extends StatefulWidget {
  const RouteScreen({super.key});

  @override
  State<RouteScreen> createState() => _RouteScreenState();
}

class _RouteScreenState extends State<RouteScreen> {
  GoogleMapController? mapController;
  Position? _currentPosition;
  Set<Polyline> _polylines = {};
  bool _loading = true;
  final LatLng _destinoEjemplo =
      const LatLng(0.8150, -77.7200); // Punto ejemplo en Tulcán

  @override
  void initState() {
    super.initState();
    _loadRoute();
  }

  Future<void> _loadRoute() async {
    setState(() => _loading = true);
    // Obtener posición actual (similar a location_screen)
    try {
      Position position = await Geolocator.getCurrentPosition(
        locationSettings:
            const LocationSettings(accuracy: LocationAccuracy.high),
      );
      if (mounted) {
        setState(() {
          _currentPosition = position;
          _loading = false;
        });

        // Polilínea para ruta ejemplo
        _polylines.add(
          Polyline(
            polylineId: const PolylineId('ruta_ejemplo'),
            points: [
              LatLng(position.latitude, position.longitude),
              _destinoEjemplo,
            ],
            color: Colors.red,
            width: 6,
            patterns: [
              PatternItem.dash(20),
              PatternItem.gap(10)
            ], // Ruta punteada para ejemplo
          ),
        );

        mapController?.animateCamera(
          CameraUpdate.newLatLngBounds(
            LatLngBounds(
              southwest: LatLng(
                [position.latitude, _destinoEjemplo.latitude]
                    .reduce((a, b) => a < b ? a : b),
                [position.longitude, _destinoEjemplo.longitude]
                    .reduce((a, b) => a < b ? a : b),
              ),
              northeast: LatLng(
                [position.latitude, _destinoEjemplo.latitude]
                    .reduce((a, b) => a > b ? a : b),
                [position.longitude, _destinoEjemplo.longitude]
                    .reduce((a, b) => a > b ? a : b),
              ),
            ),
            100.0,
          ),
        );
      }
    } catch (e) {
      setState(() => _loading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _centerOnStart() {
    if (_currentPosition != null) {
      mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target:
                LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
            zoom: 15.0,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A5F7A),
        title: const Text('VISUALIZAR RUTA',
            style: TextStyle(color: Colors.white)),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: _centerOnStart,
          ),
        ],
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFF1A5F7A)))
          : GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: const CameraPosition(
                target: LatLng(0.8101, -77.7184), // Tulcán
                zoom: 14.0,
              ),
              polylines: _polylines,
              markers: _currentPosition != null
                  ? {
                      Marker(
                        markerId: const MarkerId('inicio'),
                        position: LatLng(_currentPosition!.latitude,
                            _currentPosition!.longitude),
                        infoWindow: const InfoWindow(title: 'Inicio'),
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                            BitmapDescriptor.hueGreen),
                      ),
                      const Marker(
                        markerId: MarkerId('destino'),
                        position: LatLng(0.8150, -77.7200),
                        infoWindow: InfoWindow(title: 'Destino Ejemplo'),
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                            BitmapDescriptor.hueRed),
                      ),
                    }
                  : null,
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF1A5F7A),
        onPressed: _loadRoute,
        child: const Icon(Icons.refresh, color: Colors.white),
      ),
    );
  }
}
