import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final Map<String, dynamic> data;

  const AuthSuccess(this.data);

  @override
  List<Object?> get props => [data];
}

class AuthOtpRequired extends AuthState {
  final String phone;

  const AuthOtpRequired(this.phone);

  @override
  List<Object?> get props => [phone];
}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);

  @override
  List<Object?> get props => [message];
}