import 'package:equatable/equatable.dart';

import '../entities/entities.dart';

abstract class Authentication {
  Future<AccountEntity> auth(AuthenticationParams params) async {}
}

class AuthenticationParams extends Equatable {
  final String email;
  final String secret;

  @override
  List get props => [email, secret];

  AuthenticationParams({
    this.email,
    this.secret,
  });
}
