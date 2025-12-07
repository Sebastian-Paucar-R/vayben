import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';
import 'taxi_screen.dart';
import 'share_route_screen.dart';
import 'payment_screen.dart';
import 'location_screen.dart';
import 'route_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _showSettings(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Perfil'),
              subtitle: const Text('Usuario Mock: user@example.com'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Navegar a perfil detallado
              },
            ),
            ListTile(
              leading: Icon(themeProvider.isDarkMode
                  ? Icons.light_mode
                  : Icons.dark_mode),
              title: const Text('Modo Oscuro'),
              trailing: Switch(
                value: themeProvider.isDarkMode,
                onChanged: (value) {
                  themeProvider.toggleTheme(value);
                },
              ),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Cerrar Sesión'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      _buildDashboard(),
      const TaxiScreen(),
      const ShareRouteScreen(),
      const PaymentScreen(),
      const LocationScreen(),
      const RouteScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('VAYBEN'),
        backgroundColor: const Color(0xFF1A5F7A),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => _showSettings(context),
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) => setState(() => _currentIndex = index),
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        selectedItemColor: const Color(0xFF1A5F7A),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.local_taxi), label: 'Taxi'),
          BottomNavigationBarItem(icon: Icon(Icons.share), label: 'Compartir'),
          BottomNavigationBarItem(icon: Icon(Icons.payment), label: 'Pago'),
          BottomNavigationBarItem(
              icon: Icon(Icons.location_on), label: 'Ubicación'),
          BottomNavigationBarItem(icon: Icon(Icons.route), label: 'Ruta'),
        ],
      ),
    );
  }

  Widget _buildDashboard() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              3,
              (index) => Chip(
                label: const Text('NOTIFICACIÓN',
                    style:
                        TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                backgroundColor: Colors.grey[300],
              ),
            ),
          ),
          const SizedBox(height: 30),
          Image.asset('assets/logo_sinfondo.png', width: 80, height: 80),
          const SizedBox(height: 30),
          const Text(
            'Bienvenido a Vayben',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text('Elige un servicio desde la barra inferior.'),
          const Spacer(),
          ElevatedButton.icon(
            onPressed: () => _pageController.animateToPage(4,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut), // A Ubicación
            icon: const Icon(Icons.location_on),
            label: const Text('Ver mi ubicación actual'),
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1A5F7A)),
          ),
        ],
      ),
    );
  }
}
