import 'package:flutter/material.dart';

import '../../../../core/routes/app_routes.dart';
import '../widgets/auth_widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _createAccount() {
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
      pageTitle: 'Sign Up',
      footer: AuthSwitchFooter(
        prompt: 'Already have an account? ',
        actionLabel: 'Login',
        onPressed: () {
          Navigator.pushReplacementNamed(context, AppRoutes.login);
        },
      ),
      child: Column(
        children: [
          const AuthHeader(
            title: 'Create Your Account',
            subtitle: 'The smartest way to shop for\npremium technology.',
          ),
          const SizedBox(height: 24),
          AuthCard(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  AuthTextField(
                    controller: _nameController,
                    label: 'Full Name',
                    hintText: 'Enter your full name',
                    icon: Icons.person_outline_rounded,
                    validator: requiredText,
                  ),
                  const SizedBox(height: 16),
                  PhoneNumberField(controller: _phoneController),
                  const SizedBox(height: 16),
                  AuthTextField(
                    controller: _passwordController,
                    label: 'Password',
                    hintText: 'Create a password',
                    icon: Icons.lock_outline_rounded,
                    isPassword: true,
                    validator: requiredPassword,
                  ),
                  const SizedBox(height: 22),
                  PrimaryAuthButton(
                    label: 'Create Account',
                    onPressed: _createAccount,
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
