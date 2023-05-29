import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_app/app/storage/app_storage.dart';
import 'package:login_app/login/model/form_status.dart';
import 'package:login_app/login/model/user_model.dart';
import 'package:login_app/login/model/user_status.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<EmailLoginEvent>(_emailLoginEvent);
    on<GoogleLoginEvent>(_googleLoginEvent);
    on<LogOutEvent>(_logOutEvent);
  }

  _emailLoginEvent(EmailLoginEvent event, Emitter emit) async {
    emit(state.copy(formStatus: FormStatus.loading));
    String username = event.username;
    String email = event.email;
    String password = event.password;
    try {
      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (credential.user != null) {
        await AppStorage.setLogin(true);
        UserModel userModel = UserModel(username: username, email: email);
        await AppStorage.setUserData(userModel);
        emit(state.copy(
          username: username,
          email: email,
          error: null,
          formStatus: FormStatus.success,
          userStatus: UserStatus.logIn,
        ));
      } else {
        await AppStorage.setLogin(false);
        emit(state.copy(
          formStatus: FormStatus.failed,
          error: 'user is not find',
        ));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        log(e.toString());
        emit(state.copy(
          error: 'Email id already exist',
          formStatus: FormStatus.failed,
        ));
      }
    }
  }

  _googleLoginEvent(GoogleLoginEvent event, Emitter emit) async {
    try {
      emit(state.copy(formStatus: FormStatus.loading));
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        await AppStorage.setLogin(false);
        emit(state.copy(
          formStatus: FormStatus.failed,
          error: 'please sigh in to app',
        ));
        return;
      }
      GoogleSignInAuthentication auth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: auth.idToken,
        accessToken: auth.accessToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      User user = FirebaseAuth.instance.currentUser!;
      await AppStorage.setLogin(true);
      UserModel userModel = UserModel(
        username: user.displayName!,
        email: user.email!,
        imageUrl: user.photoURL,
      );
      await AppStorage.setUserData(userModel);
      emit(state.copy(
        username: user.displayName,
        email: user.email,
        error: null,
        formStatus: FormStatus.success,
        userStatus: UserStatus.logIn,
      ));
    } catch (e) {
      emit(state.copy(error: e.toString(), formStatus: FormStatus.failed));
    }
  }

  _logOutEvent(LogOutEvent event, Emitter emit) async {
    emit(state.copy(formStatus: FormStatus.loading));
    await AppStorage.clearData();
    await AppStorage.setLogin(false);
    emit(state.copy(
      userStatus: UserStatus.logOut,
      formStatus: FormStatus.success,
    ));
  }
}
