import 'package:flutter/material.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A5F7A),
        title: const Text('Términos y Condiciones',
            style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'TÉRMINOS Y CONDICIONES DE USO - VAYBEN',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              '1. Aceptación de los Términos\n'
              'Al utilizar VAYBEN, aceptas estos Términos y Condiciones. Si no estás de acuerdo, no uses la aplicación.\n\n'
              '2. Descripción del Servicio\n'
              'VAYBEN es una aplicación de movilidad segura para Tulcán que permite visualizar ubicación, contactar taxis locales, compartir rutas en tiempo real y verificar pagos mediante QR o comprobante.\n\n'
              '3. Uso Permitido\n'
              '• Debes tener al menos 13 años para usar la app.\n'
              '• Solo para uso personal y no comercial.\n'
              '• No está permitido modificar, copiar o distribuir el código sin autorización.\n\n'
              '4. Privacidad y Datos Personales\n'
              '• Se recopila ubicación en tiempo real solo mientras usas la app.\n'
              '• Los contactos de taxi son datos locales del dispositivo.\n'
              '• No se almacenan datos en servidores externos en esta versión.\n'
              '• Cumple con la Ley Orgánica de Protección de Datos Personales del Ecuador.\n\n'
              '5. Responsabilidad\n'
              '• VAYBEN no presta servicios de transporte.\n'
              '• No nos responsabilizamos por accidentes, pérdidas o daños durante el uso de taxis contactados.\n'
              '• El pago es responsabilidad del usuario y el conductor.\n\n'
              '6. Propiedad Intelectual\n'
              'La aplicación y su código fuente son propiedad de Sebastian Paucar R. bajo licencia MIT (ver repositorio).\n\n'
              '7. Modificaciones\n'
              'Nos reservamos el derecho de modificar estos términos en cualquier momento.\n\n'
              '8. Ley Aplicable\n'
              'Estos términos se rigen por las leyes de la República del Ecuador.\n\n'
              'Última actualización: 8 de diciembre de 2025\n'
              'Desarrollado para Laboratorio de Aplicaciones Móviles - UPEC 2025',
              style: TextStyle(fontSize: 16, height: 1.6),
            ),
          ],
        ),
      ),
    );
  }
}
