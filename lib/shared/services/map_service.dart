import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapService {
  List<LatLng> generateSimulatedRoute() {
    return [
      const LatLng(0.813, -77.717), // Añade const
      const LatLng(0.820, -77.710),
    ];
  }
}
