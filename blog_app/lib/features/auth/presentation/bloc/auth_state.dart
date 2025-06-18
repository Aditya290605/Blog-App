import 'package:blog_app/features/auth/domain/entities/user_profile.dart';
import 'package:flutter/material.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final UserProfile user;

  AuthSuccess(this.user);
}

final class AuthFailure extends AuthState {
  final String error;

  AuthFailure(this.error);
}
