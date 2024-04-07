import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:nymble_assignment/main.dart' as app;
import 'package:nymble_assignment/presentation/home_screen.dart';
import 'package:nymble_assignment/presentation/login_screen.dart';
import 'package:nymble_assignment/presentation/signup_screen.dart';
import 'package:nymble_assignment/presentation/splash_screen.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group("E2E Test", () {
    testWidgets(
        "Verify Login Screen with correct credentials and proceed to Home Screen",
        (widgetTester) async {
      app.main();
      await widgetTester.pumpAndSettle();

      await Future.delayed(const Duration(seconds: 2));
      expect(find.byType(SplashScreen), findsOneWidget);

      // Await for transition
      await widgetTester.pumpAndSettle();
      expect(find.byType(LoginScreen), findsNothing);
      expect(find.byType(SignupScreen), findsOneWidget);

      await widgetTester.tap(find.byType(TextButton).at(1));

      // For transition
      await widgetTester.pumpAndSettle();
      expect(find.byType(TextFormField), findsNWidgets(2));

      await widgetTester.enterText(find.byType(TextFormField).at(0), "nymble@gmail.com");
      await widgetTester.enterText(find.byType(TextFormField).at(1), "nymbletest");
      await widgetTester.tap(find.byType(TextButton).at(0));

      await widgetTester.pumpAndSettle();
      expect(find.byType(HomeScreen),findsOneWidget);
    });
  });
}
