import 'package:flutter_assignment/login_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/main.dart' as app;
import 'package:get/get.dart';

void main() {
  setUpAll(() {
    Get.testMode = true;
  });
  group('Login Page Tests', () {
    testWidgets('should find Email TextField', (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          home: LoginPage(),
        ),
      );
      expect(find.bySemanticsLabel('Email'), findsOneWidget);
    });

    testWidgets('should find Password TextField', (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          home: LoginPage(),
        ),
      );
      expect(find.bySemanticsLabel('Password'), findsOneWidget);
    });
    testWidgets('should navigate to /home on successful login',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          home: LoginPage(),
        ),
      );
      await tester.enterText(find.bySemanticsLabel('Email'), 'admin@gmail.com');
      await tester.enterText(find.bySemanticsLabel('Password'), 'admin@123?');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      expect(Get.currentRoute, "/");
    });
  });
}
