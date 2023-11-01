import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:valorant/business_logic/bloc/champion/champions_cubit.dart';
import 'package:valorant/ui/pages/ChampionList.dart';
import 'package:valorant/ui/pages/Maps.dart';
import '../../business_logic/bloc/map/maps_cubit.dart';
import 'Weapons.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 30, 30),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 38, 38, 38),
        elevation: 0,
        toolbarHeight: 70,
        title: Center(
          child: Container(
            margin: const EdgeInsets.only(top: 30),
            child: SvgPicture.asset(
              "./assets/valorant-logo.svg",
              width: 70,
              height: 70,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              child: Container(
                margin: const EdgeInsets.only(left: 20, top: 10),
                padding: const EdgeInsets.only(left: 20),
                width: 388.84,
                height: 194.93,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("./assets/vectorRight.png"))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        Text(
                          "AGENTS",
                          style: TextStyle(
                            fontFamily: 'monument',
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Find more ways to plant \nthe Spike and style on your\nenemies with scrappers,\nstrategists, and hunters of\nevery description.",
                          style: TextStyle(
                            fontFamily: 'poppins',
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    Image.asset(
                      "./assets/agents.png",
                      height: 165,
                      width: 170,
                    )
                  ],
                ),
              ),
              onTap: (){
                context.push('/champions');
              },
            ),
            GestureDetector(
              child: Container(
                padding: const EdgeInsets.only(left: 10),
                margin: const EdgeInsets.only(right: 20, top: 20),
                height: 194.93,
                width: 388.84,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage("./assets/vectorLeft.png"),
                )),
                child: Row(
                  children: [
                    Image.asset(
                      "./assets/iconMaps.png",
                      height: 165,
                    ),
                    const SizedBox(width: 15),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        Text(
                          "MAPS",
                          style: TextStyle(
                            fontFamily: 'monument',
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Find more ways to plant the \nSpike and style on your \nenemies with scrappers,\nstrategists, and hunters \nof every description.',
                          style: TextStyle(
                            fontFamily: 'poppins',
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              onTap: () {
                context.push('/maps');
              },
            ),
            GestureDetector(
              child: Container(
                padding: const EdgeInsets.only(left: 30),
                margin: const EdgeInsets.only(left: 20, top: 20),
                height: 194.93,
                width: 388.84,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage("./assets/vectorRight.png"),
                )),
                child: Row(
                  children: [
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        Text(
                          "WEAPONS",
                          style: TextStyle(
                            fontFamily: 'monument',
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Find more ways to plant \nthe Spike and style on your\nenemies with scrappers,\nstrategists, and hunters of\nevery description.",
                          style: TextStyle(
                            fontFamily: 'poppins',
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(width: 30),
                    Image.asset(
                      "./assets/iconWeapons.png",
                      height: 105,
                      width: 120,
                    ),
                  ],
                ),
              ),
              onTap: () {
                context.push('/weapons');
              },
            ),
          ],
        ),
      ),
    );
  }
}
