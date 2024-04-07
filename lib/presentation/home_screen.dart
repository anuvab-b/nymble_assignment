import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nymble_assignment/bloc/home/home_bloc.dart';
import 'package:nymble_assignment/presentation/favourites_screen.dart';
import 'package:nymble_assignment/presentation/music_list_screen.dart';
import 'package:nymble_assignment/presentation/profile_screen.dart';
import 'package:nymble_assignment/utils/constants.dart';
import 'package:nymble_assignment/utils/theme_styles.dart';

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
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Center(
          child: Image.asset(AppConstants.splashIconWebp,
              height: 96, color: kPrimaryIconLightColor),
        ),
        elevation: 0,
      ),
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: [
          const MusicListScreen(),
          const FavouritesScreen(),
          const ProfileScreen()
        ][bottomIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(

        onTap: (int index) {
          setState(() {
            bottomIndex = index;
          });
        },
        currentIndex: bottomIndex,
        items: [
          BottomNavigationBarItem(
            label: "Home",
            activeIcon: Icon(MdiIcons.home),
            icon: Icon(MdiIcons.homeOutline),
          ),
          BottomNavigationBarItem(
            label: "Favourites",
            activeIcon: Icon(MdiIcons.heart),
            icon: Icon(MdiIcons.heartOutline),
          ),
          const BottomNavigationBarItem(
            label: "Profile",
            activeIcon: Icon(Icons.person),
            icon: Icon(Icons.person_outline),
          )
        ],
      ),
    );
  }
}
