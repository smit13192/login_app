enum UserStatus { pure, logOut, logIn }

extension UserStatusExtension on UserStatus {
  bool get isPure => this == UserStatus.pure;
  bool get isLogIn => this == UserStatus.logIn;
  bool get isLogOut => this == UserStatus.logOut;
}
