import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vayben_new/features/routes/data/models/route_model.dart';

class AiRouteRepository {
  Future<RouteModel> generateRoute(
      double lat, double lng, String destination) async {
    // Simulación de ruta segura con IA (sin llamada HTTP por ahora)
    await Future.delayed(const Duration(seconds: 2));

    // Ruta simulada: puntos seguros desde origen a destino cercano
    return RouteModel(
      points: [
        LatLng(lat, lng),
        LatLng(lat + 0.003, lng + 0.002),
        LatLng(lat + 0.006, lng + 0.005),
        LatLng(lat + 0.01, lng + 0.01),
      ],
      duration: 8.5 + (lat - lng).abs() * 10, // Duración variable simulada
      safetyScore: 92.0 + (lat % 0.01) * 8, // Puntaje de seguridad alto
    );
  }
}
