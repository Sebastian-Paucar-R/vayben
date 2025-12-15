import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vayben/features/routes/data/models/route_model.dart';
import 'package:vayben/features/routes/domain/usecases/generate_ai_route_usecase.dart';

class RouteProvider with ChangeNotifier {
  final GenerateAiRouteUsecase usecase;
  RouteModel? currentRoute;
  bool isLoading = false;

  RouteProvider(this.usecase);

  Future<void> generateRoute(LatLng start, LatLng end) async {
    isLoading = true;
    notifyListeners();
    try {
      currentRoute = await usecase(start, end);
    } catch (e) {
      // Handle error
    }
    isLoading = false;
    notifyListeners();
  }
}
