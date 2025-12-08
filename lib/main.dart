import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/taxi_screen.dart';
import 'screens/share_route_screen.dart';
import 'screens/payment_screen.dart';
import 'screens/location_screen.dart';
import 'screens/route_screen.dart';

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
            colorScheme:
                ColorScheme.fromSeed(seedColor: const Color(0xFF1A5F7A)),
            useMaterial3: true,
            fontFamily: 'Roboto',
          ),
          darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF1A5F7A),
              brightness: Brightness.dark,
            ),
            useMaterial3: true,
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
