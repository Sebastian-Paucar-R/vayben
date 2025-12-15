import 'package:vayben_new/features/routes/data/models/route_model.dart';
import 'package:vayben_new/features/routes/data/repositories/ai_route_repository.dart';

class GenerateAiRouteUseCase {
  final AiRouteRepository repository;

  GenerateAiRouteUseCase(this.repository);

  Future<RouteModel> call(double lat, double lng, String destination) async {
    return await repository.generateRoute(lat, lng, destination);
  }
}