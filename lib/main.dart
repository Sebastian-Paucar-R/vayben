import 'package:flutter/material.dart';
import 'package:vayben/core/theme/app_theme.dart';
import 'package:vayben/features/home/presentation/screens/home_screen.dart';
import 'package:get_it/get_it.dart';
import 'package:vayben/shared/services/location_service.dart';
import 'package:vayben/shared/services/map_service.dart';

final GetIt getIt = GetIt.instance;

void main() {
  getIt.registerLazySingleton<LocationService>(() => LocationService());
  getIt.registerLazySingleton<MapService>(() => MapService());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vayben',
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      home: const HomeScreen(),
    );
  }
}
