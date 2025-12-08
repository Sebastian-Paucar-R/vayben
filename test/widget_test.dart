import 'package:flutter_test/flutter_test.dart';
import 'package:vayben/main.dart';

void main() {
  testWidgets('Vayben App Smoke Test', (WidgetTester tester) async {
    await tester.pumpWidget(const VaybenApp());

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(
        find.text('VAYBEN'), findsOneWidget); // o el texto que tengas en splash
  });
}
