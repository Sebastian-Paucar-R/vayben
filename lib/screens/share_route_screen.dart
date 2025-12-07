import 'package:flutter/material.dart';

class ShareRouteScreen extends StatelessWidget {
  const ShareRouteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A5F7A),
        title:
            const Text('COMPARTIR RUTA', style: TextStyle(color: Colors.white)),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_forward, color: Colors.green),
                  SizedBox(width: 10),
                  Text(
                    'COMPARTIR RUTA',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _socialButton(
                    'assets/whatsapp.png', () => _shareAction('WhatsApp')),
                const SizedBox(width: 30),
                _socialButton(
                    'assets/facebook.png', () => _shareAction('Facebook')),
              ],
            ),
            const SizedBox(height: 40),
            Expanded(
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.cyan[100],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'CONTACTOS',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _contactRow(
                          '0987654321', () => _shareAction('SMS a 0987654321')),
                      const SizedBox(height: 12),
                      _contactRow('0991234567',
                          () => _shareAction('Llamar a 0991234567')),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _socialButton(String asset, VoidCallback onTap) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4)
            ],
          ),
          child: Image.asset(asset, width: 60, height: 60),
        ),
      );

  Widget _contactRow(String phone, VoidCallback onTap) => ListTile(
        leading: const CircleAvatar(
          backgroundColor: Color(0xFF1A5F7A),
          child: Icon(Icons.person, color: Colors.white),
        ),
        title: Text(phone, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _miniBtn(
                Icons.sms, Colors.blue, () => _shareAction('SMS a $phone')),
            const SizedBox(width: 8),
            _miniBtn(Icons.call, Colors.green, onTap),
          ],
        ),
      );

  Widget _miniBtn(IconData icon, Color color, VoidCallback onTap) => Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(50),
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: color.withAlpha(30), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 16),
          ),
        ),
      );

  void _shareAction(String platform) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Compartiendo vía $platform')));
  }
}
