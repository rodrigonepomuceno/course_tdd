import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../login_presenter.dart';

class PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);
    return StreamBuilder<String>(
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
        });
  }
}
