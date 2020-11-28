abstract class LoginPresenter {
  void validateEmail(String email);
  void validatePassword(String password);
  void auth();
  void dispose();

  Stream get emailErrorStream;
  Stream get passwordErrorStream;
  Stream get mainErrorStream;
  Stream get isFormaValidStream;
  Stream get isLoadingStream;
}
