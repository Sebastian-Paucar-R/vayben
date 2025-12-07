import 'package:flutter/material.dart';

class TaxiScreen extends StatefulWidget {
  const TaxiScreen({super.key});

  @override
  State<TaxiScreen> createState() => _TaxiScreenState();
}

class _TaxiScreenState extends State<TaxiScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  int _selectedTab = 0;
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, String>> contacts = [
    {'name': 'Juan Pérez', 'phone': '0987654321'},
    {'name': 'Ana López', 'phone': '0991234567'},
    {'name': 'Carlos Ruiz', 'phone': '0978945612'},
  ];
  List<Map<String, String>> filteredContacts = [];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    filteredContacts = List.from(contacts);
    _animationController.forward();
  }

  void _filterContacts(String query) {
    setState(() {
      filteredContacts = contacts
          .where((contact) =>
              contact['name']!.toLowerCase().contains(query.toLowerCase()) ||
              contact['phone']!.contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A5F7A),
        title: const Text('TAXI', style: TextStyle(color: Colors.white)),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: FadeTransition(
        opacity: _animationController,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Buscar contacto...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      onChanged: _filterContacts,
                    ),
                  ),
                  const SizedBox(width: 10),
                  _tab('CONTACTOS', 0, Colors.cyan[100]!),
                  const SizedBox(width: 10),
                  _tab('FAVORITOS', 1, Colors.red[100]!),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: filteredContacts.length,
                itemBuilder: (context, i) {
                  final contact = filteredContacts[i];
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      elevation: 4,
                      child: ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Color(0xFF1A5F7A),
                          child: Icon(Icons.person, color: Colors.white),
                        ),
                        title: Text(
                          contact['phone']!,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(contact['name']!),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _actionBtn(Icons.sms, Colors.blue,
                                () => _showAction('SMS a ${contact['phone']}')),
                            const SizedBox(width: 8),
                            _actionBtn(
                                Icons.call,
                                Colors.green,
                                () => _showAction(
                                    'Llamar a ${contact['phone']}')),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tab(String title, int index, Color color) => GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: _selectedTab == index ? color : Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight:
                  _selectedTab == index ? FontWeight.bold : FontWeight.normal,
              color: _selectedTab == index ? Colors.black : Colors.grey[600],
            ),
          ),
        ),
      );

  Widget _actionBtn(IconData icon, Color color, VoidCallback onTap) => Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(50),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: color.withAlpha(30), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 20),
          ),
        ),
      );

  void _showAction(String action) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(action)));
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
  }
}
