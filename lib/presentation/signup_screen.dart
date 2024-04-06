import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nymble_assignment/bloc/signup/signup_bloc.dart';
import 'package:nymble_assignment/presentation/widgets/loader_widget.dart';
import 'package:nymble_assignment/presentation/widgets/text.dart';
import 'package:nymble_assignment/utils/colour_utils.dart';
import 'package:nymble_assignment/utils/route_names.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late TextEditingController emailTextController;
  late TextEditingController passwordTextController;
  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;
  late SignupBloc signupBloc;

  @override
  void initState() {
    super.initState();
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    signupBloc = BlocProvider.of<SignupBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const CommonText(
                value: "Sign Up",
                textColor: AppColourUtils.kWhite,
                fontSize: 20)),
        body: BlocConsumer<SignupBloc, SignupState>(
            listener: (context, state) {
              if (state is SignupSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: CommonText(
                        value: "You're signed up",
                        textColor: AppColourUtils.kWhite),
                    backgroundColor: Colors.green));
                Navigator.pushNamedAndRemoveUntil(
                    context, RouteNames.login, (Route<dynamic> route) => false);
              }
              if (state is SignupFailure) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: CommonText(
                        value: state.error, textColor: AppColourUtils.kWhite),
                    backgroundColor: Colors.red));
              } else if (state is SignupLoading) {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    barrierColor: Colors.transparent,
                    builder: (ctx) {
                      return const CommonLoader();
                    });
              } else if (state is SignupLoaded) {
                Navigator.of(context).pop();
                clearSignupForm();
              }
            },
            builder: (context, state) => Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            TextFormField(
                              onChanged: (_) {
                                signupBloc.add(SignupEmailChanged(
                                    email: emailTextController.text));
                              },
                              controller: emailTextController,
                              focusNode: emailFocusNode,
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                  labelText: "Email*",
                                  hintText: "Enter an email address"),
                            ),
                            TextFormField(
                                onChanged: (_) {
                                  signupBloc.add(SignupPasswordChanged(
                                      password: passwordTextController.text));
                                },
                                controller: passwordTextController,
                                focusNode: passwordFocusNode,
                                textInputAction: TextInputAction.done,
                                obscureText: true,
                                decoration: const InputDecoration(
                                    labelText: "Password*",
                                    hintText: "Enter a password")),
                            const SizedBox(height: 8.0),
                            TextButton(
                              onPressed: () {
                                emailFocusNode.unfocus();
                                passwordFocusNode.unfocus();
                                final SignupBloc signupBloc =
                                    BlocProvider.of<SignupBloc>(context);
                                signupBloc.add(SignupWithEmailAndPassword(
                                    email: emailTextController.text,
                                    password: passwordTextController.text));
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor:
                                      AppColourUtils.kDarkerTextColor),
                              child: const CommonText(
                                  value: "Signup",
                                  fontSize: 16,
                                  textColor: AppColourUtils.kWhite),
                            )
                          ],
                        ),
                        Column(children: [
                          const CommonText(
                              value: "Already have an account? Login here",
                              fontWeight: FontWeight.w400),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  RouteNames.login,
                                  (Route<dynamic> route) => false);
                            },
                            style: TextButton.styleFrom(
                                foregroundColor:
                                    AppColourUtils.kDarkerTextColor,
                                padding: const EdgeInsets.all(16.0),
                                textStyle: const TextStyle(fontSize: 20)),
                            child:
                                const CommonText(value: "Login", fontSize: 20),
                          )
                        ]),
                      ]),
                )));
  }

  clearSignupForm() {
    setState(() {
      passwordTextController.clear();
      emailTextController.clear();
    });
  }
}
