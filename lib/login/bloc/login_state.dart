part of 'login_bloc.dart';

@immutable
class LoginState extends Equatable {
  final String? username;
  final String? email;
  final String? error;
  final FormStatus formStatus;
  final UserStatus userStatus;

  const LoginState({
    this.username,
    this.email,
    this.error,
    this.formStatus = FormStatus.pure,
    this.userStatus = UserStatus.pure,
  });

  LoginState copy({
    String? username,
    String? email,
    String? error,
    FormStatus? formStatus,
    UserStatus? userStatus,
  }) =>
      LoginState(
        username: username ?? this.username,
        email: email ?? this.email,
        error: error,
        formStatus: formStatus ?? this.formStatus,
        userStatus: userStatus ?? this.userStatus,
      );

  @override
  List<Object?> get props => [username, email, error, formStatus, userStatus];
}
