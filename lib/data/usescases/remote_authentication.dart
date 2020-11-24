import 'package:meta/meta.dart';

import '../../domain/usecases/uses_cases.dart';
import '../../domain/helpers/helpers.dart';
import '../http/http.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({
    @required this.httpClient,
    @required this.url,
  });

  Future<void> auth(AuthenticationParams params) async {
    final body = RemoreAuthenticationParams.fromDomain(params).toJson();
    try {
      await httpClient.request(url: url, method: 'post', body: body);
    } on HttpError catch (error) {
      throw error == HttpError.unauthorized ? DomainError.invalidCredentials : DomainError.unexpected;
    }
  }
}

class RemoreAuthenticationParams {
  final String email;
  final String password;

  RemoreAuthenticationParams({
    this.email,
    this.password,
  });

  factory RemoreAuthenticationParams.fromDomain(AuthenticationParams params) =>
      RemoreAuthenticationParams(email: params.email, password: params.secret);

  Map toJson() => {'email': email, 'password': password};
}
