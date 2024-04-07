import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nymble_assignment/bloc/login/login_bloc.dart';
import 'package:nymble_assignment/utils/route_names.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Logout",
                  style:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600)),
              IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () {
                    LoginBloc authBloc = BlocProvider.of<LoginBloc>(context);
                    authBloc.add(LogoutRequested());
                    Navigator.pushNamedAndRemoveUntil(context, RouteNames.login,
                        (Route<dynamic> route) => false);
                  }),
            ],
          )
        ],
      ),
    );
  }
}
