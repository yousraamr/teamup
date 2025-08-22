import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  SignInRequested(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class SignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String name;

  SignUpRequested(this.email, this.password, this.name);

  @override
  List<Object?> get props => [email, password, name];
}

class ForgotPasswordRequested extends AuthEvent {
  final String email;

  ForgotPasswordRequested(this.email);

  @override
  List<Object?> get props => [email];
}

class SignOutRequested extends AuthEvent {}