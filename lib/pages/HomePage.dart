import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 30, 30),
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
        leading: const Icon(Icons.arrow_back_ios_new),
        title: Center(
          child: Container(
            margin: const EdgeInsets.only(top: 30, right: 60),
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
            padding: const EdgeInsets.only(left: 25),
            margin: const EdgeInsets.only(left: 35, top: 20),
            height: 180,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage("./assets/VectorRight.png"),
            )),
            child: Row(
              children: [
                Column(
                  children: const [
                    SizedBox(height: 35),
                    Text(
                      "AGENTS",
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
                Image.asset(
                  "./assets/Agents.png",
                  height: 165,
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 10),
            margin: const EdgeInsets.only(right: 35, top: 20),
            height: 180,
            decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("./assets/VectorLeft.png"),
                )),
            child: Row(
              children: [

                Image.asset(
                  "./assets/IconMaps.png",
                  height: 165,
                ),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(height: 35),
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
          Container(
            padding: const EdgeInsets.only(left: 25),
            margin: const EdgeInsets.only(left: 35, top: 20),
            height: 180,
            decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("./assets/VectorRight.png"),
                )),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(height: 35),
                    Text(
                      "WEAPONS",
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
                const SizedBox(width: 10),
                Image.asset(
                  "./assets/IconWeapons.png",
                  height: 125,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
