import 'package:course_tdd/ui/pages/pages.dart';
import 'package:provider/provider.dart';

import '../../components/components.dart';
import 'package:flutter/material.dart';

import 'components/components.dart';

class LoginPage extends StatefulWidget {
  final LoginPresenter presenter;

  LoginPage(this.presenter);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void dispose() {
    super.dispose();
    widget.presenter.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          widget.presenter.isLoadingStream.listen(
            (isLoading) {
              isLoading ? showLoading(context) : hideLoading(context);
            },
          );

          widget.presenter.mainErrorStream.listen(
            (error) {
              if (error != null) {
                showErrorMessage(context, error);
              }
            },
          );

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LoginHeader(),
                HeadLine1(text: 'LOGIN'),
                Padding(
                  padding: EdgeInsets.all(32),
                  child: Provider(
                    create: (_) => widget.presenter,
                    child: Form(
                      child: Column(
                        children: [
                          EmailInput(),
                          PasswordInput(),
                          LoginButton(),
                          FlatButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.person),
                            label: Text('Criar Conta'),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
