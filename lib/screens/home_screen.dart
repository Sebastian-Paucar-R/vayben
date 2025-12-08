import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';
import 'taxi_screen.dart';
import 'share_route_screen.dart';
import 'payment_screen.dart';
import 'route_screen.dart';
import 'terms_conditions_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  GoogleMapController? mapController;
  Position? _currentPosition;
  bool _loadingLocation = true;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    setState(() => _loadingLocation = true);

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showSnackBar('Activa GPS en Ajustes > Ubicación');
      setState(() => _loadingLocation = false);
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _showSnackBar(
            'Permiso denegado. Ve a Ajustes > VAYBEN > Ubicación > Permitir');
        setState(() => _loadingLocation = false);
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _showSnackBar('Permiso bloqueado. Abre Ajustes > VAYBEN > Ubicación');
      setState(() => _loadingLocation = false);
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
        locationSettings:
            const LocationSettings(accuracy: LocationAccuracy.high),
      );
      if (mounted) {
        setState(() {
          _currentPosition = position;
          _loadingLocation = false;
        });
        mapController?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(position.latitude, position.longitude),
                zoom: 16),
          ),
        );
      }
    } catch (e) {
      _showSnackBar('Error: $e. Verifica GPS');
      setState(() => _loadingLocation = false);
    }
  }

  void _showSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }
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
              onTap: () => Navigator.pop(context),
            ),
            SwitchListTile(
              value: themeProvider.isDarkMode,
              onChanged: (value) => themeProvider.toggleTheme(value),
              title: const Text('Modo Oscuro'),
              secondary: Icon(themeProvider.isDarkMode
                  ? Icons.dark_mode
                  : Icons.light_mode),
            ),
            ListTile(
              leading: const Icon(Icons.description),
              title: const Text('Términos y Condiciones'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TermsConditionsScreen()));
              },
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('VAYBEN'),
        backgroundColor: const Color(0xFF1A5F7A),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => _showSettings(context),
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          // Inicio: Mapa
          _loadingLocation
              ? const Center(
                  child: CircularProgressIndicator(color: Color(0xFF1A5F7A)))
              : GoogleMap(
                  onMapCreated: (controller) => mapController = controller,
                  initialCameraPosition: CameraPosition(
                    target: _currentPosition != null
                        ? LatLng(_currentPosition!.latitude,
                            _currentPosition!.longitude)
                        : const LatLng(0.8101, -77.7184), // Tulcán
                    zoom: 15,
                  ),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false, // Evita superposición
                  zoomControlsEnabled: false, // Gestos manuales
                  markers: _currentPosition != null
                      ? {
                          Marker(
                            markerId: const MarkerId('ubicacion_actual'),
                            position: LatLng(_currentPosition!.latitude,
                                _currentPosition!.longitude),
                            infoWindow: const InfoWindow(title: 'Estás aquí'),
                          ),
                        }
                      : {},
                ),
          const TaxiScreen(),
          const ShareRouteScreen(),
          const PaymentScreen(),
          const RouteScreen(),
        ],
      ),
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton(
              backgroundColor: const Color(0xFF1A5F7A),
              onPressed: _getCurrentLocation,
              child: const Icon(Icons.my_location, color: Colors.white),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF1A5F7A),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.local_taxi), label: 'Taxi'),
          BottomNavigationBarItem(icon: Icon(Icons.share), label: 'Compartir'),
          BottomNavigationBarItem(icon: Icon(Icons.payment), label: 'Pago'),
          BottomNavigationBarItem(icon: Icon(Icons.route), label: 'Ruta'),
        ],
      ),
    );
  }
}
