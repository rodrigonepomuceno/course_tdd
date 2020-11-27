import 'dart:async';

import 'package:course_tdd/ui/pages/pages.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class LoginPresenterSpy extends Mock implements LoginPresenter {}

void main() {
  LoginPresenter presenter;
  StreamController<String> emailErrorController;
  StreamController<String> passwordErrorController;
  StreamController<bool> isFormaValidController;

  Future<void> loadPage(WidgetTester tester) async {
    presenter = LoginPresenterSpy();
    emailErrorController = StreamController<String>();
    when(presenter.emailErrorStream).thenAnswer((_) => emailErrorController.stream);

    passwordErrorController = StreamController<String>();
    when(presenter.passwordErrorStream).thenAnswer((_) => passwordErrorController.stream);

    isFormaValidController = StreamController<bool>();
    when(presenter.isFormaValidController).thenAnswer((_) => isFormaValidController.stream);

    final loginPage = MaterialApp(home: LoginPage(presenter));
    await tester.pumpWidget(loginPage);
  }

  tearDown(() {
    emailErrorController.close();
    passwordErrorController.close();
    isFormaValidController.close();
  });

  testWidgets('Should load with correct initial state', (WidgetTester tester) async {
    await loadPage(tester);
    final emailTextChildren = find.descendant(of: find.bySemanticsLabel('E-mail'), matching: find.byType(Text));

    expect(emailTextChildren, findsOneWidget);

    final passwordTextChildren = find.descendant(of: find.bySemanticsLabel('Senha'), matching: find.byType(Text));

    expect(passwordTextChildren, findsOneWidget);

    final button = tester.widget<RaisedButton>(find.byType(RaisedButton));

    expect(button.onPressed, null);
  });

  testWidgets('Should call validate with correct values', (WidgetTester tester) async {
    await loadPage(tester);

    final email = faker.internet.email();
    await tester.enterText(find.bySemanticsLabel('E-mail'), email);
    verify(presenter.validateEmail(email));

    final password = faker.internet.password();
    await tester.enterText(find.bySemanticsLabel('Senha'), password);
    verify(presenter.validatePassword(password));
  });

  testWidgets('Should present error if email is invalid', (WidgetTester tester) async {
    await loadPage(tester);
    emailErrorController.add('any error');
    await tester.pump(); //força um renderização dos compoenntes em tela

    expect(find.text('any error'), findsOneWidget);
  });

  testWidgets('Should present error if password is invalid', (WidgetTester tester) async {
    await loadPage(tester);
    passwordErrorController.add('any error');
    await tester.pump(); //força um renderização dos compoenntes em tela

    expect(find.text('any error'), findsOneWidget);
  });

  testWidgets('Should present no error if email is valid', (WidgetTester tester) async {
    await loadPage(tester);
    emailErrorController.add(null);
    await tester.pump(); //força um renderização dos compoenntes em tela
    final emailTextChildren = find.descendant(of: find.bySemanticsLabel('E-mail'), matching: find.byType(Text));
    expect(emailTextChildren, findsOneWidget);
  });

  testWidgets('Should present no error if email is valid', (WidgetTester tester) async {
    await loadPage(tester);
    emailErrorController.add('');
    await tester.pump(); //força um renderização dos compoenntes em tela
    final emailTextChildren = find.descendant(of: find.bySemanticsLabel('E-mail'), matching: find.byType(Text));
    expect(emailTextChildren, findsOneWidget);
  });

  testWidgets('Should present no error if password is valid', (WidgetTester tester) async {
    await loadPage(tester);
    passwordErrorController.add(null);
    await tester.pump(); //força um renderização dos compoenntes em tela
    final passwordTextChildren = find.descendant(of: find.bySemanticsLabel('Senha'), matching: find.byType(Text));
    expect(passwordTextChildren, findsOneWidget);
  });

  testWidgets('Should present no error if password is valid', (WidgetTester tester) async {
    await loadPage(tester);
    passwordErrorController.add('');
    await tester.pump(); //força um renderização dos compoenntes em tela
    final passwordTextChildren = find.descendant(of: find.bySemanticsLabel('Senha'), matching: find.byType(Text));
    expect(passwordTextChildren, findsOneWidget);
  });

  testWidgets('Should enabled form button if form is valid', (WidgetTester tester) async {
    await loadPage(tester);
    isFormaValidController.add(true);
    await tester.pump(); //força um renderização dos compoenntes em tela
    final button = tester.widget<RaisedButton>(find.byType(RaisedButton));
    expect(button.onPressed, isNotNull);
  });

  testWidgets('Should enabled form button if form is invalid', (WidgetTester tester) async {
    await loadPage(tester);
    isFormaValidController.add(false);
    await tester.pump(); //força um renderização dos compoenntes em tela
    final button = tester.widget<RaisedButton>(find.byType(RaisedButton));
    expect(button.onPressed, null);
  });
}
