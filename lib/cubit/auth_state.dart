part of 'auth_cubit.dart';

@immutable
abstract class AuthState {
  get authResponse => null;
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final AuthResponse authResponse;

  AuthAuthenticated(this.authResponse);
}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}