import 'package:course_tdd/ui/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);

    return StreamBuilder<String>(
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
        });
  }
}
