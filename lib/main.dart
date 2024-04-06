import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nymble_assignment/bloc/login/login_bloc.dart';
import 'package:nymble_assignment/bloc/signup/signup_bloc.dart';
import 'package:nymble_assignment/bloc/splash/splash_bloc.dart';
import 'package:nymble_assignment/domain/i_auth_repository.dart';
import 'package:nymble_assignment/presentation/music_home_screen.dart';
import 'package:nymble_assignment/service_locator.dart';
import 'package:nymble_assignment/utils/route_names.dart';
import 'package:nymble_assignment/utils/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  ServiceLocator.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => SplashBloc()),
        BlocProvider(
            create: (BuildContext context) =>
                SignupBloc(getIt.get<IAuthRepository>())),
        BlocProvider(
            create: (BuildContext context) =>
                LoginBloc(getIt.get<IAuthRepository>())),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: RouteNames.splash,
          onGenerateRoute: Routes.generateRoute,
          home: const MusicHomeScreen()),
    );
  }
}
