enum LoginStateStatus {
  initial,
  error,
  admLogin,
  employeeLogin,
}

class LoginState {
  final LoginStateStatus status;
  final String? errorMessage;

  LoginState.initial() : this(status: LoginStateStatus.initial);

  LoginState({
    required this.status,
    this.errorMessage,
  });

  LoginState copyWith({
    LoginStateStatus? status,
    String? errorMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      // ignore: prefer_if_null_operators
      errorMessage: errorMessage != null ? errorMessage : this.errorMessage,
    );
  }
}
