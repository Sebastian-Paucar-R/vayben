import 'package:google_maps_flutter/google_maps_flutter.dart'; // Para LatLng

class RouteModel {
  final List<LatLng> points; // Puntos de la ruta
  final double distance; // En km
  final double duration; // En minutos
  final String safetyLevel; // e.g., 'high', 'medium'

  RouteModel({
    required this.points,
    required this.distance,
    required this.duration,
    required this.safetyLevel,
  });

  // From JSON si usas API
  factory RouteModel.fromJson(Map<String, dynamic> json) {
    return RouteModel(
      points: (json['points'] as List)
          .map((p) => LatLng(p['lat'], p['lng']))
          .toList(),
      distance: json['distance'],
      duration: json['duration'],
      safetyLevel: json['safetyLevel'],
    );
  }
}
