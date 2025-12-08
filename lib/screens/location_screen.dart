import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  GoogleMapController? mapController;
  Position? _currentPosition;
  bool _loading = true;
  final Set<Polyline> _polylines = {};
  final LatLng _tulcanCenter = const LatLng(0.8101, -77.7184);

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    setState(() => _loading = true);

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showSnackBar('Activa la ubicación en tu dispositivo');
      setState(() => _loading = false);
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _showSnackBar('Permiso de ubicación denegado');
        setState(() => _loading = false);
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _showSnackBar('Permiso denegado permanentemente. Abre ajustes.');
      setState(() => _loading = false);
      return;
    }

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
          polylineId: const PolylineId('ruta_segura'),
          points: [
            LatLng(position.latitude, position.longitude),
            _tulcanCenter,
          ],
          color: Colors.blue,
          width: 5,
        ),
      );

      mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 16.0,
          ),
        ),
      );
    } catch (e) {
      _showSnackBar('Error obteniendo ubicación: $e');
      setState(() => _loading = false);
    }
  }

  void _showSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }
  }

  Set<Marker> _buildMarkers() {
    if (_currentPosition == null) return {};
    return {
      Marker(
        markerId: const MarkerId('mi_ubicacion'),
        position:
            LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
        infoWindow: const InfoWindow(title: 'Estás aquí'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ),
      Marker(
        markerId: const MarkerId('destino'),
        position: _tulcanCenter,
        infoWindow: const InfoWindow(title: 'Centro Tulcán'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A5F7A),
        title:
            const Text('MI UBICACIÓN', style: TextStyle(color: Colors.white)),
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFF1A5F7A)))
          : GoogleMap(
              onMapCreated: (controller) => mapController = controller,
              initialCameraPosition: CameraPosition(
                target: _currentPosition != null
                    ? LatLng(
                        _currentPosition!.latitude, _currentPosition!.longitude)
                    : _tulcanCenter,
                zoom: 15.0,
              ),
              myLocationEnabled: true,
              myLocationButtonEnabled: false, // ← Evita solapamiento
              polylines: _polylines,
              markers: _buildMarkers(),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF1A5F7A),
        onPressed: _getLocation,
        child: const Icon(Icons.my_location, color: Colors.white),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.endFloat, // ← Posición derecha abajo
    );
  }
}
