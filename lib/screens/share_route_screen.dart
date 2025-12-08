import 'package:flutter/material.dart';

class ShareRouteScreen extends StatelessWidget {
  const ShareRouteScreen({super.key});

  void _shareAction(BuildContext context, String platform) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Compartiendo vía $platform')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A5F7A),
        title:
            const Text('COMPARTIR RUTA', style: TextStyle(color: Colors.white)),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: Colors.green.withAlpha(50),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.share, color: Colors.green),
                  SizedBox(width: 10),
                  Text('COMPARTIR RUTA',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.green)),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _socialButton(context, Icons.message, Colors.green, 'WhatsApp'),
                const SizedBox(width: 40),
                _socialButton(context, Icons.facebook, Colors.blue, 'Facebook'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _socialButton(
      BuildContext context, IconData icon, Color color, String platform) {
    return GestureDetector(
      onTap: () => _shareAction(context, platform),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color.withAlpha(30),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: Colors.black.withAlpha(50), blurRadius: 8)
          ],
        ),
        child: Icon(icon, size: 40, color: color),
      ),
    );
  }
}
