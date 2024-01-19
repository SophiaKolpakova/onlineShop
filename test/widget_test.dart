import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shop/presentation/screen/login/bloc/login_bloc.dart';
import 'package:shop/presentation/screen/login/bloc/login_event.dart';
import 'package:shop/presentation/screen/login/login_screen.dart';
import 'widget_test.mocks.dart';

@GenerateNiceMocks([MockSpec<LoginBloc>()])
void main() {
  const email = 'l';
  const password = '123';
  final mockBloc = MockLoginBloc();

  testWidgets('LoginScreen UI Elements and Initial State Test',
      (WidgetTester tester) async {
    await tester.pumpWidget(testApp(const LoginScreen(), mockBloc));
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);

    final loginButtonFinder = find.byKey(Key('login_btn'));
    expect(loginButtonFinder, findsOneWidget);

    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('LoginButton Tap Triggers Login Event Test',
      (WidgetTester tester) async {
    await tester.pumpWidget(testApp(const LoginScreen(), mockBloc));

    final loginButtonFinder = find.byKey(Key('login_btn'));
    expect(loginButtonFinder, findsOneWidget);

    final emailFieldFinder = find.byKey(Key('email_field'));
    final passwordFieldFinder = find.byKey(Key('password_field'));
    await tester.enterText(emailFieldFinder, email);
    await tester.enterText(passwordFieldFinder, password);

    await tester.tap(loginButtonFinder);

    await tester.pumpAndSettle();

    final capturedEvents = verify(mockBloc.add(captureAny)).captured;
    expect(capturedEvents.length, 1);
    final loginEvent = capturedEvents.single as LoginEvent;
    expect(loginEvent.email, email);
    expect(loginEvent.password, password);
  });
}

Widget testApp(Widget child, LoginBloc bloc) => BlocProvider(
      create: (BuildContext context) => bloc,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Clothes App',
        theme: ThemeData(
          primarySwatch: Colors.yellow,
        ),
        home: child,
      ),
    );
