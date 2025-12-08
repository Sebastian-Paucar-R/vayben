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
  final Set<Polyline> _polylines = {};
  bool _loading = true;
  final LatLng _destinoEjemplo = const LatLng(0.8150, -77.7200);

  @override
  void initState() {
    super.initState();
    _loadRoute();
  }

  Future<void> _loadRoute() async {
    setState(() => _loading = true);

    try {
      Position position = await Geolocator.getCurrentPosition(
        locationSettings:
            const LocationSettings(accuracy: LocationAccuracy.high),
      );

      if (!mounted) return;

      setState(() {
        _currentPosition = position;
        _loading = false;
      });

      _polylines.add(
        Polyline(
          polylineId: const PolylineId('ruta_ejemplo'),
          points: [
            LatLng(position.latitude, position.longitude),
            _destinoEjemplo,
          ],
          color: Colors.red,
          width: 6,
          patterns: [PatternItem.dash(30), PatternItem.gap(10)], // ← SIN const
        ),
      );

      final bounds = LatLngBounds(
        southwest: LatLng(
          position.latitude < _destinoEjemplo.latitude
              ? position.latitude
              : _destinoEjemplo.latitude,
          position.longitude < _destinoEjemplo.longitude
              ? position.longitude
              : _destinoEjemplo.longitude,
        ),
        northeast: LatLng(
          position.latitude > _destinoEjemplo.latitude
              ? position.latitude
              : _destinoEjemplo.latitude,
          position.longitude > _destinoEjemplo.longitude
              ? position.longitude
              : _destinoEjemplo.longitude,
        ),
      );

      mapController?.animateCamera(CameraUpdate.newLatLngBounds(bounds, 100));
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $e')));
      }
      setState(() => _loading = false);
    }
  }

  Set<Marker> _buildMarkers() {
    if (_currentPosition == null) return {};
    return {
      Marker(
        markerId: const MarkerId('inicio'),
        position:
            LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
        infoWindow: const InfoWindow(title: 'Inicio'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      ),
      Marker(
        markerId: const MarkerId('destino'),
        position: _destinoEjemplo,
        infoWindow: const InfoWindow(title: 'Destino Ejemplo'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A5F7A),
        title: const Text('VISUALIZAR RUTA',
            style: TextStyle(color: Colors.white)),
        foregroundColor: Colors.white,
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFF1A5F7A)))
          : GoogleMap(
              onMapCreated: (c) => mapController = c,
              initialCameraPosition: const CameraPosition(
                  target: LatLng(0.8101, -77.7184), zoom: 14.0),
              polylines: _polylines,
              markers: _buildMarkers(),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF1A5F7A),
        onPressed: _loadRoute,
        child: const Icon(Icons.refresh, color: Colors.white),
      ),
    );
  }
}
