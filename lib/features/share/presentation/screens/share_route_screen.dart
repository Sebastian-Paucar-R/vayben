import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';

class ShareRouteScreen extends StatefulWidget {
  const ShareRouteScreen({super.key});

  @override
  State<ShareRouteScreen> createState() => _ShareRouteScreenState();
}

class _ShareRouteScreenState extends State<ShareRouteScreen> {
  List<String> _routeHistory = [];
  late final Future<SharedPreferences> _prefs;

  @override
  void initState() {
    super.initState();
    _prefs = SharedPreferences.getInstance();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final prefs = await _prefs;
    setState(() {
      _routeHistory = prefs.getStringList('route_history') ?? [];
    });
  }

  Future<void> _addRouteToHistory(String routeDescription) async {
    final prefs = await _prefs;
    final updatedHistory = [..._routeHistory, routeDescription];
    await prefs.setStringList('route_history', updatedHistory);
    setState(() {
      _routeHistory = updatedHistory;
    });
  }

  Future<void> _shareRoute(String route) async {
    await Share.share('Mira mi ruta segura en Vayben: $route');
    _addRouteToHistory(route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compartir Ruta'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: () {
                final newRoute =
                    'Ruta del ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}: Terminal → Parque Ayora';
                _shareRoute(newRoute);
              },
              icon: const Icon(Icons.share, color: Colors.white),
              label: const Text('Compartir Ruta Actual'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Historial de rutas compartidas',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: _routeHistory.isEmpty
                ? const Center(
                    child: Text('Aún no has compartido rutas'),
                  )
                : ListView.builder(
                    itemCount: _routeHistory.length,
                    itemBuilder: (context, index) {
                      final route = _routeHistory[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        elevation: 4,
                        child: ListTile(
                          title: Text(route),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.share,
                              color: Colors.blue,
                            ),
                            onPressed: () => _shareRoute(route),
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
}
