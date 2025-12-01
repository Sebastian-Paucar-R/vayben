import 'package:flutter/material.dart';

class ShareRouteScreen extends StatelessWidget {
  const ShareRouteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xFF1A5F7A),
          title: const Text('COMPARTIR RUTA',
              style: TextStyle(color: Colors.white)),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context))),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(30)),
                child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_forward, color: Colors.green),
                      SizedBox(width: 10),
                      Text('COMPARTIR RUTA',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.green))
                    ])),
            const SizedBox(height: 30),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              _social('assets/whatsapp.png'),
              const SizedBox(width: 30),
              _social('assets/facebook.png')
            ]),
            const SizedBox(height: 40),
            Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withAlpha(20), blurRadius: 8)
                    ]),
                child: Column(children: [
                  Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 20),
                      decoration: BoxDecoration(
                          color: Colors.cyan[100],
                          borderRadius: BorderRadius.circular(20)),
                      child: const Text('CONTACTOS',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  const SizedBox(height: 16),
                  _contactRow('0987654321'),
                  const SizedBox(height: 12),
                  _contactRow('0991234567'),
                ])),
          ])),
    );
  }

  Widget _social(String asset) =>
      GestureDetector(child: Image.asset(asset, width: 60, height: 60));
  Widget _contactRow(String phone) => Row(children: [
        const CircleAvatar(
            backgroundColor: Colors.grey,
            child: Icon(Icons.person, color: Colors.white)),
        const SizedBox(width: 12),
        Text(phone, style: const TextStyle(fontWeight: FontWeight.bold)),
        const Spacer(),
        _miniBtn(Icons.sms, Colors.blue),
        const SizedBox(width: 8),
        _miniBtn(Icons.call, Colors.green),
      ]);
  Widget _miniBtn(IconData icon, Color color) => Container(
      padding: const EdgeInsets.all(6),
      decoration:
          BoxDecoration(color: color.withAlpha(30), shape: BoxShape.circle),
      child: Icon(icon, color: color, size: 16));
}
