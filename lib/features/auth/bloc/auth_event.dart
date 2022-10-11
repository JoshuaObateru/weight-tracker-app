part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignInAnonymousUserEvent extends AuthEvent {}

class SignInUserWithGoogleEvent extends AuthEvent {}

class CheckUserSignInStatus extends AuthEvent {}

class SignOutUserEvent extends AuthEvent {}
