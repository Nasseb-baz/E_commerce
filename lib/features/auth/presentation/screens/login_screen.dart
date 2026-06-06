import 'package:flutter/material.dart';

import '../../../../core/routes/app_routes.dart';
import '../widgets/auth_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _continueToOtp() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushNamed(
        context,
        AppRoutes.otp,
        arguments: _phoneController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthPageLayout(
      pageTitle: 'Login',
      footer: AuthSwitchFooter(
        prompt: "Don't have an account? ",
        actionLabel: 'Sign Up',
        onPressed: () {
          Navigator.pushReplacementNamed(context, AppRoutes.signUp);
        },
      ),
      child: Column(
        children: [
          const AuthHeader(
            title: 'Welcome Back',
            subtitle: 'The smartest way to shop for\npremium technology.',
          ),
          const SizedBox(height: 28),
          AuthCard(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  PhoneNumberField(controller: _phoneController),
                  const SizedBox(height: 20),
                  AuthTextField(
                    controller: _passwordController,
                    label: 'Password',
                    hintText: 'Enter Password',
                    icon: Icons.lock_outline_rounded,
                    isPassword: true,
                    validator: requiredPassword,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.forgotPassword);
                      },
                      child: const Text('Forgot Password?'),
                    ),
                  ),
                  const SizedBox(height: 6),
                  PrimaryAuthButton(
                    label: 'Continue',
                    onPressed: _continueToOtp,
                  ),
                  const SizedBox(height: 20),
                  const SecurityFooter(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          GuestArea(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.home,
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
