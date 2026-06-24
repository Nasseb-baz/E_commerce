import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routes/app_routes.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
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

  void _login() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            LoginRequested(
              phone: _phoneController.text.trim(),
              password: _passwordController.text.trim(),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.home,
            (route) => false,
          );
        }

        if (state is AuthOtpRequired) {
          Navigator.pushNamed(
            context,
            AppRoutes.otp,
            arguments: state.phone,
          );
        }

        if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: AuthPageLayout(
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
                          Navigator.pushNamed(
                            context,
                            AppRoutes.forgotPassword,
                          );
                        },
                        child: const Text('Forgot Password?'),
                      ),
                    ),
                    const SizedBox(height: 6),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        final isLoading = state is AuthLoading;

                        return PrimaryAuthButton(
                          label: 'Continue',
                          isLoading: isLoading,
                          onPressed: _login,
                        );
                      },
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
      ),
    );
  }
}
