import 'package:flutter/material.dart';

import '../../../../ui/pages/pages.dart';
import '../../factories.dart';
import 'login_presenter_factory.dart';

Widget makeLoginPage() {
  return LoginPage(makeLoginPresenter());
}
