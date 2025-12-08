import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vayben/main.dart';

void main() {
  testWidgets('Vayben App Smoke Test', (WidgetTester tester) async {
    await tester.pumpWidget(const VaybenApp());

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
  });
}
