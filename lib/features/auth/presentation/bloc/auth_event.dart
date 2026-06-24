import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LoginRequested extends AuthEvent {
  final String phone;
  final String password;

  const LoginRequested({
    required this.phone,
    required this.password,
  });

  @override
  List<Object?> get props => [phone, password];
}

class RegisterRequested extends AuthEvent {
  final String name;
  final String phone;
  final String password;

  const RegisterRequested({
    required this.name,
    required this.phone,
    required this.password,
  });

  @override
  List<Object?> get props => [name, phone, password];
}

class VerifyOtpRequested extends AuthEvent {
  final String phone;
  final String otp;

  const VerifyOtpRequested({
    required this.phone,
    required this.otp,
  });

  @override
  List<Object?> get props => [phone, otp];
}