abstract class LoginPresenter {
  void validateEmail(String email);
  void validatePassword(String password);
  Future<void> auth();
  void dispose();

  Stream<String> get emailErrorStream;
  Stream<String> get passwordErrorStream;
  Stream<String> get mainErrorStream;
  Stream<bool> get isFormaValidStream;
  Stream<bool> get isLoadingStream;
}
