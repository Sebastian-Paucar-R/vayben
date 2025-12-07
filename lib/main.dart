import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart'; // Nuevo archivo para tema
import 'screens/route_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/taxi_screen.dart';
import 'screens/share_route_screen.dart';
import 'screens/payment_screen.dart';
import 'screens/location_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const VaybenApp(),
    ),
  );
}

class VaybenApp extends StatelessWidget {
  const VaybenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'VAYBEN',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: const MaterialColor(0xFF1A5F7A, <int, Color>{
              50: Color(0xFFE8F5E8),
              100: Color(0xFFC8E6C9),
              200: Color(0xFFA5D6A7),
              300: Color(0xFF81C784),
              400: Color(0xFF66BB6A),
              500: Color(0xFF4CAF50),
              600: Color(0xFF43A047),
              700: Color(0xFF388E3C),
              800: Color(0xFF2E7D32),
              900: Color(0xFF1B5E20),
            }),
            fontFamily: 'Roboto',
            useMaterial3: true,
            brightness: Brightness.light,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF1A5F7A),
              secondary: const Color(0xFFFF6B35),
            ),
          ),
          darkTheme: ThemeData(
            primarySwatch: const MaterialColor(0xFF1A5F7A, <int, Color>{
              50: Color(0xFF001A1A),
              // ... (ajustar para dark)
            }),
            fontFamily: 'Roboto',
            useMaterial3: true,
            brightness: Brightness.dark,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF1A5F7A),
              brightness: Brightness.dark,
              secondary: const Color(0xFFFF6B35),
            ),
          ),
          themeMode: themeProvider.themeMode,
          initialRoute: '/splash',
          routes: {
            '/splash': (context) => const SplashScreen(),
            '/login': (context) => const LoginScreen(),
            '/register': (context) => const RegisterScreen(),
            '/home': (context) => const HomeScreen(),
            '/taxi': (context) => const TaxiScreen(),
            '/share': (context) => const ShareRouteScreen(),
            '/payment': (context) => const PaymentScreen(),
            '/location': (context) => const LocationScreen(),
            '/route': (context) => const RouteScreen(),
          },
        );
      },
    );
  }
}
