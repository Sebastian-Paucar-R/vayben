import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              icon: Image.asset('assets/icono_x.png', width: 24, height: 24),
              onPressed: () {}),
          actions: [
            IconButton(
                icon: Image.asset('assets/icono_x.png', width: 24, height: 24),
                onPressed: () {})
          ]),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                    3,
                    (_) => Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(20)),
                        child: const Text('NOTIFICACIONES',
                            style: TextStyle(
                                fontSize: 11, fontWeight: FontWeight.bold))))),
            const SizedBox(height: 30),
            Image.asset('assets/logo_sinfondo.png', width: 80, height: 80),
            const SizedBox(height: 30),
            _serviceButton(context, 'TAXI', 'assets/icono_taxi.png',
                Colors.yellow, '/taxi'),
            const SizedBox(height: 16),
            _serviceButton(context, 'COMPARTIR RUTA',
                'assets/icono_compartir.png', Colors.green[100]!, '/share'),
            const SizedBox(height: 16),
            _serviceButton(context, 'FORMA DE PAGO', 'assets/icono_pago.png',
                Colors.orange[100]!, '/payment'),
            const SizedBox(height: 16),
            _serviceButton(context, 'UBICACIÓN', 'assets/icono_ubicacion.png',
                Colors.cyan[100]!, '/location'),
            const SizedBox(height: 16),
            _serviceButton(context, 'VISUALIZAR RUTA', 'assets/icono_ruta.png',
                Colors.pink[100]!, '/route'),
          ],
        ),
      ),
    );
  }

  Widget _serviceButton(BuildContext context, String title, String icon,
      Color color, String route) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withAlpha(26),
                  blurRadius: 8,
                  offset: const Offset(0, 4))
            ]),
        child: Row(
          children: [
            Image.asset(icon, width: 32, height: 32),
            const SizedBox(width: 16),
            Text(title,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87)),
            const Spacer(),
            Image.asset('assets/icono_x.png', width: 20, height: 20),
          ],
        ),
      ),
    );
  }
}
