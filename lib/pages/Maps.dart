import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:valorant/pages/MapDetail.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  List _maps = [];

  Future<void> _fetchData() async {
    const apiUrl = 'https://valorant-api.com/v1/maps';

    final response = await http.get(Uri.parse(apiUrl));
    final data = json.decode(response.body);

    setState(() {
      _maps = data["data"];
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
      body: Container(
        child: _maps.isEmpty
            ? const Center(
                child: Text("Is loading"),
              )
            : ListView.builder(
                itemCount: _maps.length,
                itemBuilder: (BuildContext context, index) {
                  return InkWell(
                    child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 40),
                        width: MediaQuery.of(context).size.width,
                        height: 140,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                opacity: 0.7,
                                fit: BoxFit.cover,
                                // TODO: Scegliere listViewIcon (leggera ma peggiore) o splash (pesante ma migliore)
                                image: NetworkImage(
                                  _maps[index]["listViewIcon"],
                                ))),
                        child: Text(
                          _maps[index]["displayName"].toUpperCase(),
                          style: const TextStyle(
                            fontFamily: 'monument',
                            fontSize: 26,
                            color: Colors.white,
                          ),
                        )),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MapDetail(maps: _maps[index]),
                        ),
                      );
                    },
                  );
                }),
      ),
    );
  }
}
