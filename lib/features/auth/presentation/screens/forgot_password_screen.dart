import 'package:flutter/material.dart';

import '../../../../core/routes/app_routes.dart';
import '../widgets/auth_widgets.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validateConfirmation(String? value) {
    final passwordError = requiredPassword(value);
    if (passwordError != null) {
      return passwordError;
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
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
      pageTitle: 'Forgot Password',
      child: Column(
        children: [
          const AuthHeader(
            title: 'Reset Password',
            subtitle:
                'Enter your phone number and create a new password\nto continue to OTP verification.',
          ),
          const SizedBox(height: 24),
          AuthCard(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  PhoneNumberField(controller: _phoneController),
                  const SizedBox(height: 18),
                  AuthTextField(
                    controller: _passwordController,
                    label: 'New Password',
                    hintText: 'Enter New Password',
                    icon: Icons.lock_outline_rounded,
                    isPassword: true,
                    validator: requiredPassword,
                  ),
                  const SizedBox(height: 16),
                  AuthTextField(
                    controller: _confirmPasswordController,
                    label: 'Confirm Password',
                    hintText: 'Re-enter New Password',
                    icon: Icons.lock_outline_rounded,
                    isPassword: true,
                    validator: _validateConfirmation,
                  ),
                  const SizedBox(height: 22),
                  PrimaryAuthButton(
                    label: 'Continue to OTP',
                    onPressed: _continueToOtp,
                  ),
                  const SizedBox(height: 20),
                  const SecurityFooter(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Back to Login'),
          ),
        ],
      ),
    );
  }
}
