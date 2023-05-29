part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {}

class EmailLoginEvent extends LoginEvent {
  final String username;
  final String email;
  final String password;

  EmailLoginEvent({
    required this.username,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [username,email,password];
}

class GoogleLoginEvent extends LoginEvent {
  @override
  List<Object?> get props => [];
}

class LogOutEvent extends LoginEvent {
  @override
  List<Object?> get props => [];

}
