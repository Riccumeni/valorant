import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';

import 'WeaponsDetail.dart';
import 'image.dart';

class WeaponsPage extends StatefulWidget {
  const WeaponsPage({super.key});

  @override
  State<WeaponsPage> createState() => _WeaponsPageState();
}

class _WeaponsPageState extends State<WeaponsPage> {
  List _weapons = [];

  Future<void> _fetchData() async {
    const apiUrl = 'https://valorant-api.com/v1/weapons';

    final response = await http.get(Uri.parse(apiUrl));
    final data = json.decode(response.body);

    setState(() {
      _weapons = data["data"];
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 30, 30),
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
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
      body: Container(
        child: _weapons.isEmpty
            ? const Center(
                child: Text("Is loading", style: TextStyle(color: Colors.white),),
              )
            : ListView.builder(
                itemCount: _weapons.length,
                itemBuilder: (BuildContext context, index) {
                  return InkWell(
                    child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        alignment: Alignment.bottomLeft,
                        padding: const EdgeInsets.only(
                            left: 40, bottom: 10, top: 20, right: 20),
                        width: MediaQuery.of(context).size.width,
                        height: 160,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 40, 40, 40),
                            image: DecorationImage(
                              alignment: const Alignment(0.8, 0),
                                scale: 2.4,
                                image: NetworkImage(
                                  _weapons[index]["displayIcon"],
                                ))),
                        child: Text(
                          _weapons[index]["displayName"].toUpperCase(),
                          style: const TextStyle(
                            fontFamily: 'monument',
                            fontSize: 26,
                            color: Colors.white,
                          ),
                        )),
                    onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CarouselSliderExample(weapons: _weapons[index]),
                    ),
                  );
                },
                  );
                }),
      ),
    );
  }
}
