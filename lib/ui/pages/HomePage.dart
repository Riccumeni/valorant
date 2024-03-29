import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:valorant/ui/components/HomeCard.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool exit = false;

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
      body: WillPopScope(
        onWillPop: () async{

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Exit Dialog'),
                content: Text('You would close the app?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('NO'),
                  ),
                  TextButton(
                    onPressed: () {
                      exit = true;
                      Navigator.of(context).pop();
                    },
                    child: Text('YES'),
                  ),
                ],
              );
            },
          );

          return exit;
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              HomeCard(
                  title: "AGENTS",
                  description: "Find more ways to plant \nthe Spike and style on your\nenemies with scrappers,\nstrategists, and hunters of\nevery description.",
                  imageUrl: "./assets/agents.png",
                  destination: "/champions"
              ),

              HomeCard(
                  title: "MAPS",
                  description: "Find more ways to plant \nthe Spike and style on your\nenemies with scrappers,\nstrategists, and hunters of\nevery description.",
                  imageUrl: "./assets/iconMaps.png",
                  destination: "/maps",
                rotate: true,
              ),

              HomeCard(
                  title: "WEAPONS",
                  description: "Find more ways to plant \nthe Spike and style on your\nenemies with scrappers,\nstrategists, and hunters of\nevery description.",
                  imageUrl: "./assets/iconWeapons.png",
                  destination: "/weapons"
              ),
            ],
          ),
        ),
      ),
    );
  }
}
