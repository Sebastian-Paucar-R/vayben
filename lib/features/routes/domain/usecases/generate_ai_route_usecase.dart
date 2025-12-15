import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vayben/features/routes/data/models/route_model.dart';
import 'package:vayben/features/routes/data/repositories/ai_route_repository.dart';

class GenerateAiRouteUsecase {
  final AiRouteRepository repository;

  GenerateAiRouteUsecase(this.repository);

  Future<RouteModel> call(LatLng start, LatLng end) async {
    return await repository.generateAiRoute(start, end);
  }
}
