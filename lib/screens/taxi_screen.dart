import 'package:flutter/material.dart';

class TaxiScreen extends StatefulWidget {
  const TaxiScreen({super.key});
  @override
  State<TaxiScreen> createState() => _TaxiScreenState();
}

class _TaxiScreenState extends State<TaxiScreen> {
  int _selectedTab = 0;
  final List<Map<String, String>> contacts = [
    {'name': 'Juan Pérez', 'phone': '0987654321'},
    {'name': 'Ana López', 'phone': '0991234567'},
    {'name': 'Carlos Ruiz', 'phone': '0978945612'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xFF1A5F7A),
          title: const Text('TAXI', style: TextStyle(color: Colors.white)),
          leading: IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () {})),
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(children: [
                _tab('CONTACTOS', 0, Colors.cyan[100]!),
                const SizedBox(width: 10),
                _tab('FAVORITOS', 1, Colors.red[100]!),
              ])),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: contacts.length,
              itemBuilder: (context, i) =>
                  _contactCard(contacts[i]['name']!, contacts[i]['phone']!),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tab(String title, int index, Color color) => Expanded(
        child: GestureDetector(
          onTap: () => setState(() => _selectedTab = index),
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                  color: _selectedTab == index ? color : Colors.grey[200],
                  borderRadius: BorderRadius.circular(20)),
              child: Text(title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: _selectedTab == index
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: _selectedTab == index
                          ? Colors.black
                          : Colors.grey[600]))),
        ),
      );

  Widget _contactCard(String name, String phone) => Card(
        margin: const EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 2,
        child: ListTile(
          leading: const CircleAvatar(
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, color: Colors.white)),
          title:
              Text(phone, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(name),
          trailing: Row(mainAxisSize: MainAxisSize.min, children: [
            _actionBtn(Icons.sms, Colors.blue),
            const SizedBox(width: 8),
            _actionBtn(Icons.call, Colors.green),
          ]),
        ),
      );

  Widget _actionBtn(IconData icon, Color color) => Container(
      padding: const EdgeInsets.all(8),
      decoration:
          BoxDecoration(color: color.withAlpha(30), shape: BoxShape.circle),
      child: Icon(icon, color: color, size: 20));
}
