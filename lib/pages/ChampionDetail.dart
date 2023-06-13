import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

import '../PaintTriangle.dart';

class ChampionDetail extends StatefulWidget {
  const ChampionDetail({Key? key}) : super(key: key);

  @override
  State<ChampionDetail> createState() => _ChampionDetailState();
}

class _ChampionDetailState extends State<ChampionDetail> {

  late Map _champ;

  int _position = 0;

  Future<void> _fetchData() async {
    const apiUrl = 'https://valorant-api.com/v1/agents/dade69b4-4f5a-8528-247b-219e5a1facd6';

    final response = await http.get(Uri.parse(apiUrl));
    final data = json.decode(response.body);

    setState(() {
      _champ = data["data"];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(102, 55, 108, 1),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        toolbarHeight: 100,
        title: Center(
          child: Container(
            margin: const EdgeInsets.only(top: 0, right: 60),
            child: Text(
              _champ["displayName"].toUpperCase(),
              style: const TextStyle(
                fontFamily: 'monument',
                fontSize: 28,
              ),
            ),
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 30, 30, 30),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            CustomPaint(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(_champ["background"]),
                  )
                ),
                  child: Image(image: NetworkImage(_champ["fullPortrait"]),)
              ),
              size: Size(300, 300),
              painter: PaintTriangle(backgroundColor: Color.fromRGBO(102, 55, 108, 1), screenWidth: MediaQuery.of(context).size.width),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 50, left: 30),
                child: Text(
                  "Description".toUpperCase(),
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 24, color: Colors.white, fontFamily: 'monument'),
                )
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 20, left: 30, right: 30,),
                child: Text(
                  _champ["description"],
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 14, color: Colors.white, fontFamily: 'poppins'),
                )
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 50, left: 30),
                child: Text(
                  _champ["role"]["displayName"].toUpperCase(),
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 24, color: Colors.white, fontFamily: 'monument'),
                )
            ),
            Container(
              margin: EdgeInsets.only(top: 20, right: 30, left: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      _champ["role"]["description"],
                      textAlign: TextAlign.left,
                      softWrap: true,
                      style: TextStyle(fontSize: 14, color: Colors.white, fontFamily: 'poppins'),
                    ),
                  ),
                  Image(
                      width: 55,
                      height: 55,
                      image: NetworkImage(_champ["role"]["displayIcon"]))
                ],
              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 50, left: 30),
                child: Text(
                  "abilities".toUpperCase(),
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 24, color: Colors.white, fontFamily: 'monument'),
                )
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Container(margin: EdgeInsets.only(top: 20),child: Image(width: 40, height: 40, image: NetworkImage(_champ["abilities"][0]["displayIcon"]))),
                      Container( margin: EdgeInsets.only(top: 20),child: Text("C", style: TextStyle(fontSize: 20, fontFamily: 'valorant', color: Colors.white),)),
                      Container(
                        color: Colors.white,
                        margin: EdgeInsets.only(top: 20, bottom: 20),
                        child: SizedBox(width: 31, height: 5,),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(margin: EdgeInsets.only(top: 20),child: Image(width: 40, height: 40, image: NetworkImage(_champ["abilities"][1]["displayIcon"]))),
                      Container( margin: EdgeInsets.only(top: 20),child: Text("Q", style: TextStyle(fontSize: 20, fontFamily: 'valorant', color: Colors.white),)),
                      Container(
                        color: Colors.white,
                        margin: EdgeInsets.only(top: 20, bottom: 20),
                        child: SizedBox(width: 31, height: 5,),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(margin: EdgeInsets.only(top: 20),child: Image(width: 40, height: 40, image: NetworkImage(_champ["abilities"][2]["displayIcon"]))),
                      Container( margin: EdgeInsets.only(top: 20),child: Text("E", style: TextStyle(fontSize: 20, fontFamily: 'valorant', color: Colors.white),)),
                      Container(
                        color: Colors.white,
                        margin: EdgeInsets.only(top: 20, bottom: 20),
                        child: SizedBox(width: 31, height: 5,),
                      )
                    ],
                  ),
                  Container(
                    child: Column(
                      children: [
                        Container(margin: EdgeInsets.only(top: 20),child: Image(width: 40, height: 40, image: NetworkImage(_champ["abilities"][3]["displayIcon"]), color: Colors.white.withOpacity(.5),)),
                        Container( margin: EdgeInsets.only(top: 20),child: Text("X", style: TextStyle(fontSize: 20, fontFamily: 'valorant', color: Colors.white.withOpacity(.5)),)),
                        Container(
                          color: Colors.white.withOpacity(.5),
                          margin: EdgeInsets.only(top: 20, bottom: 20),
                          child: SizedBox(width: 31, height: 5,),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
