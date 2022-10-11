import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:obateru_joshua_weight_tracker_app/features/auth/data/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      // TODO: implement event handler
      if (event is SignInAnonymousUserEvent) {
        emit(AuthLoading());
        try {
          final user = await authRepository.signInUserAnonymously();
          emit(Authenticated(user: user));
        } catch (e) {
          emit(AuthError(message: e.toString()));
          emit(UnAuthenticated());
        }
      } else if (event is SignInUserWithGoogleEvent) {
        emit(AuthLoading());
        try {
          final user = await authRepository.signInUserWithGoogle();
          emit(GoogleAuthenticated(user: user));

          emit(Authenticated(user: user));
        } catch (e) {
          emit(AuthError(message: e.toString()));
          emit(UnAuthenticated());
        }
      } else if (event is SignOutUserEvent) {
        emit(AuthLoading());
        await authRepository.signOutUser();
        emit(UnAuthenticated());
      } else if (event is CheckUserSignInStatus) {
        emit(AuthLoading());
        final user = await authRepository.getUserSignedInStatus();
        if (user == null) {
          emit(UnAuthenticated());
        } else {
          emit(Authenticated(user: user));
        }
      }
    });
  }
}
