import 'package:course_tdd/ui/pages/pages.dart';

import '../../components/components.dart';
import 'package:flutter/material.dart';

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
              if (isLoading) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  child: SimpleDialog(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 10),
                          Text(
                            'Aguarde...',
                            textAlign: TextAlign.center,
                          )
                        ],
                      )
                    ],
                  ),
                );
              } else {
                if (Navigator.canPop(context)) {
                  Navigator.of(context).pop();
                }
              }
            },
          );

          widget.presenter.mainErrorStream.listen(
            (error) {
              if (error != null) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red[900],
                    content: Text(
                      error,
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
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
                  child: Form(
                    child: Column(
                      children: [
                        StreamBuilder<String>(
                            stream: widget.presenter.emailErrorStream,
                            builder: (context, snapshot) {
                              return TextFormField(
                                onChanged: widget.presenter.validateEmail,
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
                            stream: widget.presenter.passwordErrorStream,
                            builder: (context, snapshot) {
                              return Padding(
                                padding: EdgeInsets.only(top: 8, bottom: 32),
                                child: TextFormField(
                                  onChanged: widget.presenter.validatePassword,
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
                            stream: widget.presenter.isFormaValidStream,
                            builder: (context, snapshot) {
                              return RaisedButton(
                                onPressed: snapshot.data == true ? widget.presenter.auth : null,
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
          );
        },
      ),
    );
  }
}
