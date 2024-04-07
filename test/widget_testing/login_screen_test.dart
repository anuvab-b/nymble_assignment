import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nymble_assignment/bloc/login/login_bloc.dart';
import 'package:nymble_assignment/infrastructure/auth_repository.dart';
import 'package:nymble_assignment/presentation/login_screen.dart';

void main() {
  testWidgets("Display Login Screen with InputFields and Button",
      (widgetTester) async {
    await widgetTester.pumpWidget(MaterialApp(
      home: BlocProvider<LoginBloc>(
          create: (BuildContext context) => LoginBloc(AuthRepository()),
          child: const LoginScreen()),
    ));

    expect(find.byType(TextFormField), findsNWidgets(2));

    final button = find.text("Signup");
    expect(button, findsOneWidget);
    expect(find.byType(TextButton), findsNWidgets(2));
  });
}
