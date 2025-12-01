import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo_sinfondo.png', width: 220, height: 220),
            const SizedBox(height: 20),
            const Text('VAYBEN',
                style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A5F7A))),
            const Text('Movilidad Segura.',
                style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFFFF6B35),
                    fontStyle: FontStyle.italic)),
            const SizedBox(height: 40),
            const CircularProgressIndicator(color: Color(0xFF1A5F7A)),
          ],
        ),
      ),
    );
  }
}
