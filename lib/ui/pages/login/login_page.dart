import 'package:course_tdd/ui/pages/pages.dart';

import '../../components/components.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final LoginPresenter presenter;

  LoginPage(this.presenter);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LoginHeader(),
            HeadLine1(text: 'LOGIN'),
            Padding(
              padding: EdgeInsets.all(32),
              child: Form(
                child: Column(
                  children: [
                    StreamBuilder<String>(
                        stream: presenter.emailErrorStream,
                        builder: (context, snapshot) {
                          return TextFormField(
                            onChanged: presenter.validateEmail,
                            decoration: InputDecoration(
                              labelText: 'E-mail',
                              errorText: snapshot.data?.isEmpty == true ? null : snapshot.data,
                              icon: Icon(
                                Icons.email,
                                color: Theme.of(context).primaryColorLight,
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          );
                        }),
                    StreamBuilder<String>(
                        stream: presenter.passwordErrorStream,
                        builder: (context, snapshot) {
                          return Padding(
                            padding: EdgeInsets.only(top: 8, bottom: 32),
                            child: TextFormField(
                              onChanged: presenter.validatePassword,
                              decoration: InputDecoration(
                                labelText: 'Senha',
                                errorText: snapshot.data?.isEmpty == true ? null : snapshot.data,
                                icon: Icon(
                                  Icons.lock,
                                  color: Theme.of(context).primaryColorLight,
                                ),
                              ),
                              obscureText: true,
                            ),
                          );
                        }),
                    StreamBuilder<bool>(
                        stream: presenter.isFormaValidController,
                        builder: (context, snapshot) {
                          return RaisedButton(
                            onPressed: snapshot.data == true ? () {} : null,
                            child: Text('ENTRAR'),
                          );
                        }),
                    FlatButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.person),
                      label: Text('Criar Conta'),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
