part of 'login_bloc.dart';

@immutable
class LoginState extends Equatable {
  final String? username;
  final String? email;
  final String? error;
  final UserStatus userStatus;

  const LoginState({
    this.username,
    this.email,
    this.error,
    this.userStatus = UserStatus.pure,
  });

  LoginState copy({
    String? username,
    String? email,
    String? error,
    UserStatus? userStatus,
  }) =>
      LoginState(
        username: username ?? this.username,
        email: email ?? this.email,
        error: error,
        userStatus: userStatus ?? this.userStatus,
      );

  @override
  List<Object?> get props => [username, email, error, userStatus];
}
