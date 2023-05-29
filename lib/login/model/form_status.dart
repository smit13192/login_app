enum FormStatus { pure, loading, failed, success }

extension FormStatusExtension on FormStatus {
  bool get isPure => this == FormStatus.pure;
  bool get isLoading => this == FormStatus.loading;
  bool get isFailed => this == FormStatus.failed;
  bool get isSuccess => this == FormStatus.success;
}
