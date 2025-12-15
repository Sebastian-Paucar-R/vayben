import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Position> getCurrentLocation() async {
    // Versión temporal para probar (o usa Geolocator real)
    return Position(
      latitude: 0.5667,
      longitude: -77.2667,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0.0, // Añade .0 para double
      heading: 0.0,
      speed: 0.0,
      speedAccuracy: 0.0,
      altitudeAccuracy: 0.0,
      headingAccuracy: 0.0,
    );
  }
}
