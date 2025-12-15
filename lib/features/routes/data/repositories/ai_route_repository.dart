import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart'; // ← AÑADIDO: Esto resuelve LatLng
import 'package:vayben/features/routes/data/models/route_model.dart'; // Ajustado al nombre de paquete correcto (ver nota abajo)

class AiRouteRepository {
  Future<RouteModel> generateAiRoute(LatLng start, LatLng end) async {
    // Ejemplo: Llama a API AI (reemplaza con tu endpoint real cuando lo tengas)
    final response = await http.post(
      Uri.parse('https://your-ai-api.com/generate-route'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'start': {'lat': start.latitude, 'lng': start.longitude},
        'end': {'lat': end.latitude, 'lng': end.longitude},
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return RouteModel.fromJson(data);
    } else {
      throw Exception('Failed to generate route: ${response.statusCode}');
    }
  }
}
