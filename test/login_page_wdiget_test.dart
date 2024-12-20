import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_assignment/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('LoginPage Widget Tests', () {
    testWidgets('Check if all required widgets are present',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginPage()));

      // Check for AppBar title
      expect(find.byKey(const Key('AppBarTitle')), findsOneWidget);

      // Check for Welcome Text
      expect(find.byKey(const Key('WelcomeText')), findsOneWidget);

      // Check for Email Field
      expect(find.byKey(const Key('EmailField')), findsOneWidget);

      // Check for Password Field
      expect(find.byKey(const Key('PasswordField')), findsOneWidget);

      // Check for Login Button
      expect(find.byKey(const Key('LoginButton')), findsOneWidget);

      // Check for Signup Button
      expect(find.byKey(const Key('SignupButton')), findsOneWidget);
    });

    testWidgets('Test user interaction with Email and Password fields',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginPage()));

      await tester.enterText(
          find.byKey(const Key('EmailField')), 'test@example.com');
      expect(find.text('test@example.com'), findsOneWidget);

      await tester.enterText(
          find.byKey(const Key('PasswordField')), 'password123');
      expect(find.text('password123'), findsOneWidget);
    });

    testWidgets('Test Login Button functionality with invalid credentials',
        (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({
        'email': 'admin@gmail.com',
        'password': 'admin@123?',
      });

      await tester.pumpWidget(const MaterialApp(home: LoginPage()));

      await tester.enterText(
          find.byKey(const Key('EmailField')), 'wrong@example.com');
      await tester.enterText(
          find.byKey(const Key('PasswordField')), 'wrongpassword');

      await tester.tap(find.byKey(const Key('LoginButton')));
      await tester.pump();

      expect(find.text('Invalid email or password. Please try again.'),
          findsOneWidget);
    });
  });
}
