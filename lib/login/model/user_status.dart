enum UserStatus { pure, loading, failed, success }

extension UserStatusExtension on UserStatus {
  bool get isPure => this == UserStatus.pure;
  bool get isLoading => this == UserStatus.loading;
  bool get isFailed => this == UserStatus.failed;
  bool get isSuccess => this == UserStatus.success;
}
