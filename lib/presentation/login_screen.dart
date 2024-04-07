import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nymble_assignment/bloc/login/login_bloc.dart';
import 'package:nymble_assignment/presentation/widgets/loader_widget.dart';
import 'package:nymble_assignment/presentation/widgets/text.dart';
import 'package:nymble_assignment/utils/route_names.dart';
import 'package:nymble_assignment/utils/theme_styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailTextController;
  late TextEditingController passwordTextController;
  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;
  late LoginBloc loginBloc;

  @override
  void initState() {
    super.initState();
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    loginBloc = BlocProvider.of<LoginBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: CommonText(
                      value: "You're logged in",
                      textColor: kTitleTextDarkColor),
                  backgroundColor: Colors.green));
              Navigator.pushNamedAndRemoveUntil(
                  context, RouteNames.home, (Route<dynamic> route) => false);
            }
            if (state is LoginFailure) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: CommonText(
                      value: state.error, textColor: kTitleTextDarkColor),
                  backgroundColor: Colors.red));
            } else if (state is LoginLoading) {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  barrierColor: Colors.transparent,
                  builder: (ctx) {
                    return const CommonLoader();
                  });
            } else if (state is LoginLoaded) {
              Navigator.of(context).pop();
              clearLoginForm();
            }
          },
          builder: (context, state) => Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16.0),
                          const CommonText(
                              value: "Login",
                              textColor: kTitleTextDarkColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 32),
                          const SizedBox(height: 32.0),
                          TextFormField(
                            onChanged: (_) {
                              loginBloc.add(LoginEmailChanged(
                                  email: emailTextController.text));
                            },
                            controller: emailTextController,
                            focusNode: emailFocusNode,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                                labelText: "Email*",
                                hintText: "Enter an email address"),
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                              onChanged: (_) {
                                loginBloc.add(LoginPasswordChanged(
                                    password: passwordTextController.text));
                              },
                              controller: passwordTextController,
                              focusNode: passwordFocusNode,
                              textInputAction: TextInputAction.done,
                              obscureText: true,
                              decoration: const InputDecoration(
                                  labelText: "Password*",
                                  hintText: "Enter a password")),
                          const SizedBox(height: 16.0),
                          SizedBox(
                            height: 48.0,
                            width: MediaQuery.of(context).size.width,
                            child: TextButton(
                              onPressed: () {
                                emailFocusNode.unfocus();
                                passwordFocusNode.unfocus();
                                loginBloc.add(
                                    LoginWithEmailAndPasswordRequested(
                                        email: emailTextController.text,
                                        password: passwordTextController.text));
                              },
                              style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                  backgroundColor: kBodyTextColorDark),
                              child: const CommonText(
                                  value: "Login",
                                  fontSize: 16,
                                  textColor: kTitleTextDarkColor),
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          // SizedBox(
                          //   height: 50,
                          //   child: TextButton(
                          //     onPressed: () async {
                          //       emailFocusNode.unfocus();
                          //       passwordFocusNode.unfocus();
                          //       loginBloc.add(LoginWithGoogleRequested());
                          //     },
                          //     style: TextButton.styleFrom(
                          //         shape: RoundedRectangleBorder(
                          //           borderRadius: BorderRadius.circular(16),
                          //         ),
                          //         backgroundColor:
                          //             Theme.of(context).primaryColorLight,
                          //         foregroundColor:
                          //             Theme.of(context).primaryColor),
                          //     child: Row(
                          //       mainAxisAlignment: MainAxisAlignment.start,
                          //       children: [
                          //         SvgPicture.asset(AppConstants.icGoogle),
                          //         const SizedBox(width: 32.0),
                          //         Text(
                          //           "Sign in with Google",
                          //           maxLines: 1,
                          //           style: TextStyle(
                          //               fontFamily: "Poppins",
                          //               fontWeight: FontWeight.w500,
                          //               fontSize: 16,
                          //               color:
                          //                   Theme.of(context).primaryColor),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          // const SizedBox(height: 16.0),
                        ],
                      ),
                      Column(children: [
                        const CommonText(
                            value: "Don't have an account?",
                            fontWeight: FontWeight.w400),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                                context,
                                RouteNames.signUp,
                                (Route<dynamic> route) => false);
                          },
                          style: TextButton.styleFrom(
                              foregroundColor: kTitleTextDarkColor,
                              padding: const EdgeInsets.all(16.0),
                              textStyle: const TextStyle(fontSize: 20)),
                          child: const CommonText(
                              value: "Signup",
                              fontSize: 20,
                              textColor: AppColors.darkThemeSecondary),
                        )
                      ]),
                    ]),
              )),
    ));
  }

  clearLoginForm() {
    setState(() {
      passwordTextController.clear();
      emailTextController.clear();
    });
  }
}
