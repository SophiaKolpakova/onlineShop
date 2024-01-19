import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shop/presentation/screen/dashboard_of_fragments.dart';
import 'package:shop/presentation/main.dart' as app;

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  const email = 'kolpak@gmail.com';
  const password = '123456';

  testWidgets('Login and Check Navigation Integration Test',
      (WidgetTester tester) async {
      app.main();
      await tester.pump(const Duration(seconds: 5));
      await tester.pumpAndSettle(const Duration(seconds: 3));
      final emailField = find.byKey(const Key('email_field'));
      final passwordField = find.byKey(const Key('password_field'));
      final loginButton = find.byKey(const Key('login_btn'));

      await tester.pumpAndSettle(const Duration(seconds: 3));

      await tester.enterText(emailField, email);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      await tester.enterText(passwordField, password);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      await tester.tap(loginButton);
      await tester.pumpAndSettle(const Duration(seconds: 5));

      expect(find.byType(DashboardOfFragments), findsOneWidget);
  });
}
