import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vayben/main.dart'; // ← Este import es clave

void main() {
  testWidgets('Vayben App Smoke Test', (WidgetTester tester) async {
    // Construye la app y dispara un frame
    await tester.pumpWidget(const VayBenApp());

    // Verifica que se cargue correctamente
    expect(find.byType(MaterialApp), findsOneWidget);
    expect(
        find.text('VAYBEN'), findsNothing); // o el texto que tengas en splash
  });
}
