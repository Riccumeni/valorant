import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:valorant/pages/Maps.dart';
import 'Weapons.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 30, 30),
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
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
      body: Column(
        children: [
          Container(
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "AGENTS",
                      style: TextStyle(
                        fontFamily: 'monument',
                        fontSize: 26,
                        color: Colors.white,
                      ),
                    ),
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
                )
              ],
            ),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(height: 45),
                      Text(
                        "MAPS",
                        style: TextStyle(
                          fontFamily: 'monument',
                          fontSize: 26,
                          color: Colors.white,
                        ),
                      ),
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
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MapsPage(),
                ),
              );
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(height: 45),
                      Text(
                        "WEAPONS",
                        style: TextStyle(
                          fontFamily: 'monument',
                          fontSize: 26,
                          color: Colors.white,
                        ),
                      ),
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
                  const SizedBox(width: 13),
                  Image.asset(
                    "./assets/iconWeapons.png",
                    height: 125,
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const WeaponsPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
