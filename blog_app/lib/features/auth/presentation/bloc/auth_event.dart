import 'package:flutter/material.dart';

@immutable
sealed class AuthEvent {}

class AuthSignUp extends AuthEvent {
  final String email;
  final String name;
  final String password;

  AuthSignUp({required this.email, required this.password, required this.name});
}

class AuthSignIn extends AuthEvent {
  final String email;
  final String password;

  AuthSignIn({required this.email, required this.password});
}

class UserCurrentLogin extends AuthEvent {}
