import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_app/app/storage/app_storage.dart';
import 'package:login_app/login/model/user_status.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<EmailLoginEvent>(emailLoginEvent);
    on<GoogleLoginEvent>(googleLoginEvent);
  }

  emailLoginEvent(EmailLoginEvent event, Emitter emit) async {
    emit(state.copy(userStatus: UserStatus.loading));
    String username = event.username;
    String email = event.email;
    String password = event.password;
    try {
      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (credential.user != null) {
        String imageUrl = credential.user?.photoURL ?? '';
        AppStorage.setLogin(true);
        await AppStorage.setUserData(email, username, imageUrl);
        emit(state.copy(
          username: username,
          email: email,
          error: null,
          userStatus: UserStatus.success,
        ));
      } else {
        AppStorage.setLogin(false);
        emit(state.copy(
          userStatus: UserStatus.failed,
          error: 'user is not find',
        ));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        log(e.toString());
        emit(state.copy(
            error: 'Email id already exist', userStatus: UserStatus.failed));
      }
    }
  }

  googleLoginEvent(GoogleLoginEvent event, Emitter emit) async {
    try {
      emit(state.copy(userStatus: UserStatus.loading));
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        AppStorage.setLogin(false);
        emit(state.copy(
          userStatus: UserStatus.failed,
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
      AppStorage.setLogin(true);
      await AppStorage.setUserData(user.email ?? '', user.displayName ??  '', user.photoURL ?? '');
      emit(state.copy(
        username: user.displayName,
        email: user.email,
        error: null,
        userStatus: UserStatus.success,
      ));
    } catch (e) {
      emit(state.copy(error: e.toString(), userStatus: UserStatus.failed));
    }
  }
}
