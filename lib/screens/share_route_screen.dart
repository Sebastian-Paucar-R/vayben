import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareRouteScreen extends StatelessWidget {
  const ShareRouteScreen({super.key});

  void _shareRoute() {
    Share.share(
      '¡Estoy usando VAYBEN! La app de movilidad segura en Tulcán 🚕\nDescárgala aquí: https://vayben.app',
      subject: 'Te invito a usar VAYBEN',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A5F7A),
        title:
            const Text('COMPARTIR RUTA', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              width: double.infinity,
              height: 80,
              child: ElevatedButton.icon(
                onPressed: _shareRoute,
                icon: const Icon(Icons.share, size: 32),
                label: const Text(
                  'COMPARTIR RUTA',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[400],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
