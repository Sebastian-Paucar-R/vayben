import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vayben/features/routes/data/models/route_model.dart';

class AiRouteRepository {
  final String apiKey = 'AIzaSyBAnGAKv18ODrE_R9A5TXPWiNgZbAYsVNA';

  Future<RouteModel> generateAiRoute(LatLng start, LatLng end) async {
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/directions/json?'
      'origin=${start.latitude},${start.longitude}&'
      'destination=${end.latitude},${end.longitude}&'
      'key=$apiKey&'
      'alternatives=true',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == 'OK') {
        final route = data['routes'][0];
        final encodedPolyline = route['overview_polyline']['points'];
        final List<LatLng> points = _decodePolyline(encodedPolyline);

        final durationMinutes = route['legs'][0]['duration']['value'] / 60.0;

        return RouteModel(
          points: points,
          duration: durationMinutes,
          safetyScore:
              92.0 + (durationMinutes % 8), // Simulación de "seguridad"
        );
      } else {
        throw Exception('Error Directions API: ${data['status']}');
      }
    } else {
      throw Exception('HTTP Error: ${response.statusCode}');
    }
  }

  // Decodificador simple de polyline sin paquete externo
  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }
    return points;
  }
}
