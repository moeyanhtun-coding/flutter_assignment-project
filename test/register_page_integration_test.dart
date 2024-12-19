import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_assignment/main.dart'; // Assuming your app's main.dart is here
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('Login Page Tests', () {
    testWidgets('Login with valid credentials', (tester) async {
      // Set up SharedPreferences mock
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', 'admin@gmail.com');
      await prefs.setString('password', 'admin@123?');

      // Build the LoginPage
      await tester.pumpWidget(const MyApp());

      // Enter email and password
      await tester.enterText(
          find.byKey(const Key('EmailField')), 'admin@gmail.com');
      await tester.enterText(
          find.byKey(const Key('PasswordField')), 'admin@123?');

      // Tap the login button
      await tester.tap(find.byKey(const Key('LoginButton')));
      await tester.pumpAndSettle();

      // Verify that the login was successful (assuming the navigation to dashboard)
      expect(find.byKey(const Key('DashboardPage')),
          findsOneWidget); // Adjust if needed

      // Check if Snackbar shows the correct message for success
      expect(find.text("Welcome to the dashboard"), findsOneWidget);
    });

    testWidgets('Login with invalid credentials', (tester) async {
      // Set up SharedPreferences mock
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', 'admin@gmail.com');
      await prefs.setString('password', 'admin@123?');

      // Build the LoginPage
      await tester.pumpWidget(const MyApp());

      // Enter incorrect email and password
      await tester.enterText(
          find.byKey(const Key('EmailField')), 'wrong_email@gmail.com');
      await tester.enterText(
          find.byKey(const Key('PasswordField')), 'wrong_password');

      // Tap the login button
      await tester.tap(find.byKey(const Key('LoginButton')));
      await tester.pumpAndSettle();

      // Verify that an error message is displayed
      expect(find.text('Invalid email or password. Please try again.'),
          findsOneWidget);
    });

    testWidgets('Signup navigation works', (tester) async {
      // Build the LoginPage
      await tester.pumpWidget(const MyApp());

      // Tap the signup button
      await tester.tap(find.byKey(const Key('SignupButton')));
      await tester.pumpAndSettle();

      // Verify that the user navigates to the signup page
      expect(find.byKey(const Key('SignupPage')),
          findsOneWidget); // Adjust as needed
    });
  });
}
