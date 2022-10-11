part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final User user;
  const Authenticated({required this.user});
}

class GoogleAuthenticated extends AuthState {
  final User user;
  const GoogleAuthenticated({required this.user});
}

class UnAuthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;
  const AuthError({required this.message});
}
