import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vayben - Movilidad Segura'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButton<String>(
              value: 'Populares',
              isExpanded: true,
              items: ['Populares', 'Seguras', 'Rápidas']
                  .map((value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ))
                  .toList(),
              onChanged: (_) {},
            ),
          ),
          Container(
            height: 300,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: const GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(0.813, -77.717),
                  zoom: 14.0,
                ),
                myLocationEnabled: true,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Expanded(
            child: Center(
              child: Text(
                'Selecciona una ruta o genera una IA segura',
                style: TextStyle(
                    fontSize: 16), // Ya está optimizado lo máximo posible
              ),
            ),
          ),
        ],
      ),
    );
  }
}
