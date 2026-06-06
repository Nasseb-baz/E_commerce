import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:e_commerce/core/routes/app_routes.dart';
import 'package:e_commerce/main.dart';

void main() {
  testWidgets('get started opens phone-only sign up', (tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Next Step'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Next Step'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();

    expect(find.text('Create Your Account'), findsOneWidget);
    expect(find.text('Full Name'), findsOneWidget);
    expect(find.text('Phone Number'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Email'), findsNothing);
  });

  testWidgets('skip opens sign up immediately', (tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();

    expect(find.text('Create Your Account'), findsOneWidget);
  });

  testWidgets('sign up submits to verification', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Enter your full name'),
      'Test User',
    );
    await tester.enterText(
      find.byKey(const Key('phone_number_field')),
      '5551234567',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Create a password'),
      'secret123',
    );
    await tester.ensureVisible(find.text('Create Account'));
    await tester.tap(find.text('Create Account'));
    await tester.pumpAndSettle();

    expect(find.text('Verification'), findsOneWidget);
    expect(find.text('Enter Code'), findsOneWidget);
  });

  testWidgets('login link and forgot password open their screens',
      (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Login'));
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    expect(find.text('Welcome Back'), findsOneWidget);

    await tester.ensureVisible(find.text('Forgot Password?'));
    await tester.tap(find.text('Forgot Password?'));
    await tester.pumpAndSettle();

    expect(find.text('Reset Password'), findsOneWidget);
    expect(find.text('Confirm Password'), findsOneWidget);
  });

  testWidgets('sign up link from login opens account creation', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Sign Up'));
    await tester.pumpAndSettle();

    expect(find.text('Create Your Account'), findsOneWidget);
  });

  testWidgets('complete otp opens home', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        initialRoute: AppRoutes.otp,
        routes: AppRoutes.routes,
      ),
    );

    for (final digit in ['1', '2', '3', '4', '5', '6']) {
      await tester.ensureVisible(find.text(digit));
      await tester.tap(find.text(digit));
    }
    await tester.ensureVisible(find.text('Verify Identity'));
    await tester.tap(find.text('Verify Identity'));
    await tester.pumpAndSettle();

    expect(find.text('Home'), findsOneWidget);
  });
}
