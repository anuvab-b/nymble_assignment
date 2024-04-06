import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nymble_assignment/bloc/splash/splash_bloc.dart';
import 'package:nymble_assignment/utils/colour_utils.dart';
import 'package:nymble_assignment/utils/constants.dart';
import 'package:nymble_assignment/utils/route_names.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    final SplashBloc splashBloc = BlocProvider.of<SplashBloc>(context);
    splashBloc.add(OnNavigateFromSplash());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashAuthenticated) {
            Navigator.pushNamedAndRemoveUntil(
                context, RouteNames.home, (Route<dynamic> route) => false);
          } else if (state is SplashUnAuthenticated) {
            Navigator.pushNamedAndRemoveUntil(
                context, RouteNames.signUp, (Route<dynamic> route) => false);
          }
        },
        builder: (context, state) {
          if (state is SplashInit) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppConstants.splashIconWebp),
              ],
            );
          }
          return Container();
        },
        // child:
      ),
    );
  }
}
