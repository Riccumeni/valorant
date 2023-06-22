import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:valorant/pages/ChampionDetail.dart';
import 'package:cached_network_image/cached_network_image.dart';


class ChampionList extends StatefulWidget {
  const ChampionList({Key? key}) : super(key: key);

  @override
  State<ChampionList> createState() => _ChampionListState();
}

class _ChampionListState extends State<ChampionList> {

  Future<Map<String, dynamic>> _getChampions() async {
    const apiUrl = 'https://valorant-api.com/v1/agents';

    final response = await http.get(Uri.parse(apiUrl));
    final data = json.decode(response.body);

    return data;
  }

  late Future<Map<String, dynamic>> _champs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _champs = _getChampions();
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

      body: FutureBuilder(
        future: _champs,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.hasData){
            Map<String, dynamic> champsRes = snapshot.data;
            for(int i = 0; i< champsRes["data"].length; i++){
              if(champsRes["data"][i]["isPlayableCharacter"] == false){
                champsRes["data"].remove(champsRes["data"][i]);
              }
            }
            return GridView.builder(
              itemCount: champsRes["data"].length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 230,
                mainAxisSpacing: 40
              ),
              itemBuilder: (_, index){
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ChampionDetail(champ: champsRes["data"][index]),
                      ),
                    );
                  },
                  child: Stack(
                    alignment: Alignment.topCenter,
                    fit: StackFit.passthrough,
                    children: [
                      SvgPicture.asset('assets/champ-container.svg', width: 160, height: 130, color: Color(int.parse("0xFF${champsRes["data"][index]["backgroundGradientColors"][1].toString().substring(0, 6)}")),),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              child: CachedNetworkImage(imageUrl: champsRes["data"][index]["bustPortrait"],)
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                              child: Text("${champsRes["data"][index]["displayName"]}".toUpperCase(), style: TextStyle(color: Color.fromARGB(255, 30, 30, 30), fontFamily: 'monument', fontSize: 22),)
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          }else{
            return Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }
}
