import 'package:flutter/material.dart';

import '../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../features/auth/presentation/screens/home_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/otp_screen.dart';
import '../../features/auth/presentation/screens/sign_up_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const onboarding = '/';
  static const signUp = '/sign-up';
  static const login = '/login';
  static const forgotPassword = '/forgot-password';
  static const otp = '/otp';
  static const home = '/home';

  static Map<String, WidgetBuilder> get routes => {
        onboarding: (_) => const OnboardingScreen(),
        signUp: (_) => const SignUpScreen(),
        login: (_) => const LoginScreen(),
        forgotPassword: (_) => const ForgotPasswordScreen(),
        otp: (_) => const OtpScreen(),
        home: (_) => const HomeScreen(),
      };
}
