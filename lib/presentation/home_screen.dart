import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nymble_assignment/bloc/home/home_bloc.dart';
import 'package:nymble_assignment/presentation/favourites_screen.dart';
import 'package:nymble_assignment/presentation/music_list_screen.dart';
import 'package:nymble_assignment/presentation/profile_screen.dart';
import 'package:nymble_assignment/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeBloc homeBloc;
  int bottomIndex = 0;

  @override
  void initState() {
    super.initState();
    homeBloc = BlocProvider.of<HomeBloc>(context);
    homeBloc.add(OnHomeInit());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Image.asset(AppConstants.splashIconWebp, height: 96),
        ),
        elevation: 0,
      ),
      body: [
        const MusicListScreen(),
        const FavouritesScreen(),
        const ProfileScreen()
      ][bottomIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            bottomIndex = index;
          });
        },
        selectedIndex: bottomIndex,
        destinations: <NavigationDestination>[
          NavigationDestination(
            selectedIcon: Icon(MdiIcons.home),
            icon: Icon(MdiIcons.homeOutline),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(MdiIcons.heart),
            icon: Icon(MdiIcons.heartOutline),
            label: 'Favourites',
          ),
          const NavigationDestination(
            selectedIcon: Icon(Icons.person),
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
