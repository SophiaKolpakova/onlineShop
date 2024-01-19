import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shop/presentation/main.dart' as app;
import 'package:shop/presentation/main.dart'; // Replace with the actual path to your main.dart

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized(); // NEW

  testWidgets('Login and Check State Integration Test', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    final emailField = find.byKey(Key('emailField'));
    final passwordField = find.byKey(Key('passwordField'));
    final loginButton = find.byKey(Key('loginButton'));
    await tester.enterText(emailField, 'test@example.com');
    await tester.enterText(passwordField, 'password123');
    await tester.tap(loginButton);
    await tester.pumpAndSettle();
    expect(find.text('Welcome'), findsOneWidget);
  });
}
