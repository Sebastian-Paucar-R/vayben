import 'package:flutter/foundation.dart';
import 'package:vayben_new/features/routes/data/models/route_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteProvider extends ChangeNotifier {
  RouteModel? route;
  bool isLoading = false;
  String? errorMessage;

  Future<void> generateRoute(double lat, double lng, String destination) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    // Simulación temporal
    await Future.delayed(const Duration(seconds: 2));

    route = RouteModel(
      points: [
        LatLng(lat, lng),
        LatLng(lat + 0.01, lng + 0.01),
      ],
      duration: 15.5,
      safetyScore: 92.0,
    );

    isLoading = false;
    notifyListeners();
  }
}