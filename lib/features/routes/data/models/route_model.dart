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

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    var list = json['points'] as List<dynamic>? ?? [];
    List<LatLng> pointsList = list.map((i) => LatLng(i['lat'] as double, i['lng'] as double)).toList();

    return RouteModel(
      points: pointsList,
      duration: (json['duration'] as num?)?.toDouble() ?? 0.0,
      safetyScore: (json['safetyScore'] as num?)?.toDouble() ?? 0.0,
    );
  }
}