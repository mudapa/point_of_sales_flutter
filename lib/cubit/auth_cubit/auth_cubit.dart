import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/user_model.dart';
import '../../services/auth_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void signIn({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      UserModel user = await AuthService().signIn(
        email: email,
        password: password,
      );

      emit(AuthSuccess(user));
    } on SocketException {
      emit(const AuthFailure('No internet connection'));
    } on FirebaseAuthException catch (e) {
      emit(
        AuthFailure(
          e.code == 'invalid-credential'
              ? 'Invalid email or password'
              : e.code == 'network-request-failed'
                  ? 'No internet connection'
                  : e.message!,
        ),
      );
    }
  }

  void signUp(
      {required String email,
      required String password,
      required String name,
      required int phoneNumber}) async {
    emit(AuthLoading());
    try {
      UserModel user = await AuthService().signUp(
        email: email,
        password: password,
        name: name,
        phoneNumber: phoneNumber,
      );

      emit(RegisterSuccess(user));
    } on SocketException {
      emit(const AuthFailure('No internet connection'));
    } on FirebaseAuthException catch (e) {
      emit(
        AuthFailure(
          e.code == 'email-already-in-use'
              ? 'Email already in use'
              : e.code == 'network-request-failed'
                  ? 'No internet connection'
                  : e.message!,
        ),
      );
    }
  }

  void getCurrentUser() async {
    emit(AuthLoading());
    try {
      UserModel user = await AuthService().getUserById();

      emit(AuthSuccess(user));
    } on SocketException {
      emit(const AuthFailure('No internet connection'));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  void signOut() async {
    emit(AuthLoading());
    try {
      await AuthService().signOut();

      emit(AuthInitial());
    } on SocketException {
      emit(const AuthFailure('No internet connection'));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
