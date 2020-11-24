import '../entities/entities.dart';

abstract class Authentication {
  Future<AccountEntity> auth(AuthenticationParams params) async {}
}

class AuthenticationParams {
  final String email;
  final String secret;

  AuthenticationParams({
    this.email,
    this.secret,
  });
}
