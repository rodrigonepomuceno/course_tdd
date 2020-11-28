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
  StreamController<String> mainErrorController;
  StreamController<bool> isFormaValidController;
  StreamController<bool> isLoadingController;

  void initStreams() {
    emailErrorController = StreamController<String>();
    passwordErrorController = StreamController<String>();
    isFormaValidController = StreamController<bool>();
    isLoadingController = StreamController<bool>();
    mainErrorController = StreamController<String>();
  }

  void mockStreams() {
    when(presenter.emailErrorStream).thenAnswer((_) => emailErrorController.stream);
    when(presenter.passwordErrorStream).thenAnswer((_) => passwordErrorController.stream);
    when(presenter.isFormaValidStream).thenAnswer((_) => isFormaValidController.stream);
    when(presenter.isLoadingStream).thenAnswer((_) => isLoadingController.stream);
    when(presenter.mainErrorStream).thenAnswer((_) => mainErrorController.stream);
  }

  void closeStreams() {
    emailErrorController.close();
    passwordErrorController.close();
    isFormaValidController.close();
    isLoadingController.close();
    mainErrorController.close();
  }

  Future<void> loadPage(WidgetTester tester) async {
    presenter = LoginPresenterSpy();
    initStreams();
    mockStreams();

    final loginPage = MaterialApp(home: LoginPage(presenter));
    await tester.pumpWidget(loginPage);
  }

  tearDown(() {
    closeStreams();
  });

  testWidgets('Should load with correct initial state', (WidgetTester tester) async {
    await loadPage(tester);
    final emailTextChildren = find.descendant(of: find.bySemanticsLabel('E-mail'), matching: find.byType(Text));

    expect(emailTextChildren, findsOneWidget);

    final passwordTextChildren = find.descendant(of: find.bySemanticsLabel('Senha'), matching: find.byType(Text));

    expect(passwordTextChildren, findsOneWidget);

    final button = tester.widget<RaisedButton>(find.byType(RaisedButton));

    expect(button.onPressed, null);
    expect(find.byType(CircularProgressIndicator), findsNothing);
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

  testWidgets('Should call authentication on form submit', (WidgetTester tester) async {
    await loadPage(tester);

    isFormaValidController.add(true);
    await tester.pump();
    await tester.tap(find.byType(RaisedButton));
    await tester.pump();

    verify(presenter.auth()).called(1);
  });

  testWidgets('Should present loading', (WidgetTester tester) async {
    await loadPage(tester);

    isLoadingController.add(true);
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Should hide loading', (WidgetTester tester) async {
    await loadPage(tester);

    isLoadingController.add(true);
    await tester.pump();

    isLoadingController.add(false);
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('Should present error message if authentication if fails', (WidgetTester tester) async {
    await loadPage(tester);

    mainErrorController.add('main error');
    await tester.pump();

    expect(find.text('main error'), findsOneWidget);
  });

  testWidgets('Should close streams on dispose', (WidgetTester tester) async {
    await loadPage(tester);

    addTearDown(() {
      verify(presenter.dispose()).called(1);
    });
  });
}
