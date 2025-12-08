import 'package:flutter/material.dart';

class Contact {
  final String name;
  final String phone;
  bool isFavorite;

  Contact({required this.name, required this.phone, this.isFavorite = false});
}

class TaxiScreen extends StatefulWidget {
  const TaxiScreen({super.key});

  @override
  State<TaxiScreen> createState() => _TaxiScreenState();
}

class _TaxiScreenState extends State<TaxiScreen> {
  int _selectedTab = 0;
  final TextEditingController _searchController = TextEditingController();

  List<Contact> allContacts = [
    Contact(name: "Juan Pérez", phone: "0987654321"),
    Contact(name: "Ana López", phone: "0991234567", isFavorite: true),
    Contact(name: "Carlos Ruiz", phone: "0978945612"),
    Contact(name: "María Gómez", phone: "0965432109", isFavorite: true),
  ];

  List<Contact> get filteredContacts {
    final query = _searchController.text.toLowerCase();
    final contacts = _selectedTab == 0
        ? allContacts
        : allContacts.where((c) => c.isFavorite).toList();
    return contacts
        .where((c) =>
            c.name.toLowerCase().contains(query) || c.phone.contains(query))
        .toList();
  }

  void _toggleFavorite(Contact contact) {
    setState(() {
      contact.isFavorite = !contact.isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A5F7A),
        title: const Text('TAXI', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      hintText: 'Buscar contacto...',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                _tabButton('CONTACTOS', 0),
                const SizedBox(width: 10),
                _tabButton('FAVORITOS', 1),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredContacts.length,
              itemBuilder: (context, index) {
                final contact = filteredContacts[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFF1A5F7A),
                      child: Text(contact.name[0],
                          style: const TextStyle(color: Colors.white)),
                    ),
                    title: Text(contact.phone,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(contact.name),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            contact.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color:
                                contact.isFavorite ? Colors.red : Colors.grey,
                          ),
                          onPressed: () => _toggleFavorite(contact),
                        ),
                        IconButton(
                            icon: const Icon(Icons.message, color: Colors.blue),
                            onPressed: () {}),
                        IconButton(
                            icon: const Icon(Icons.call, color: Colors.green),
                            onPressed: () {}),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabButton(String text, int index) {
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: _selectedTab == index
              ? const Color(0xFF1A5F7A)
              : Colors.grey[300],
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: _selectedTab == index ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
