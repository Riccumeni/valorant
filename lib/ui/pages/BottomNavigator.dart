import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:valorant/business_logic/bloc/map/maps_cubit.dart';
import 'package:valorant/business_logic/bloc/skins/skin_cubit.dart';
import 'package:valorant/ui/pages/ChampionDetail.dart';
import 'package:valorant/ui/pages/Maps.dart';
import 'package:valorant/ui/pages/ChampionList.dart';
import 'package:valorant/ui/pages/FavouritePage.dart';
import 'package:valorant/ui/pages/HomePage.dart';
import 'package:valorant/ui/pages/WeaponsDetail.dart';
import 'package:valorant/ui/pages/Weapons.dart';
import '../../business_logic/bloc/champion/champions_cubit.dart';
import '../../business_logic/bloc/weapon/weapon_cubit.dart';
import 'package:valorant/ui/pages/MapDetail.dart';
import 'package:valorant/ui/pages/SkinDetail.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int _selectedIndex = 0;

  static final GoRouter router = GoRouter(initialLocation: "/", routes: [
    GoRoute(path: '/', builder: (context, state) => const HomePage()),
    GoRoute(
        path: '/champions',
        builder: (context, state) => ChampionList()
    ),
    GoRoute(
      path: '/champion-detail',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
            key: state.pageKey,
            child: ChampionDetail(),
            transitionsBuilder: (context, animation, secondaryAnimation,
                child) {
              return ScaleTransition(
                scale: CurveTween(curve: Curves.easeOutCirc).animate(
                    animation),
                child: child,
              );
            }
        );
      },
    ),
    GoRoute(
      path: '/weapons',
      builder: (context, state) => WeaponsPage(),
    ),
    GoRoute(
        path: '/weapon-detail',
        builder: (context, state) => WeaponDetail()
    ),
    GoRoute(path: '/maps',
    builder: (context, state) => MapsPage()
    ),
    GoRoute(path: '/map-detail',
    builder: (context, state) => MapDetail()
    ),
    GoRoute(
      path: '/skin-detail/:id',
      name: 'skin-detail',
      builder: (context, state) => BlocProvider(create: (context) => SkinCubit(), child: SkinDetail(
        id: state.pathParameters['id'] ?? '',
      ),)
    ),
  ]);

  static final GoRouter favouriteRouter =
      GoRouter(initialLocation: '/', routes: [
    GoRoute(
        path: '/',
        builder: (context, state) => FavouritePage()),
  ]);

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static final List<Widget> _widgetOptions = <Widget>[
    MaterialApp.router(
      routerConfig: router,
    ),
    MaterialApp.router(
      routerConfig: favouriteRouter,
    )
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ChampionsCubit()),
            BlocProvider(create: (context) => WeaponCubit()),
            BlocProvider(create: (context) => SkinCubit()),
            BlocProvider(create: (context) => MapsCubit()),
          ],
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 38, 38, 38),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourites',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 239, 88, 90),
        onTap: _onItemTapped,
      ),
    );
  }
}
