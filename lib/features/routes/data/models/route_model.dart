import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteModel {
  final List<LatLng> points;
  final double duration;
  final double safetyScore;

  RouteModel({
    required this.points,
    required this.duration,
    required this.safetyScore,
  });
}
