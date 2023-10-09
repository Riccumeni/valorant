import 'dart:convert';
import 'dart:ffi';

import 'package:valorant/data/data_providers/ValorantAPI.dart';

import '../models/champion/ChampionsResponse.dart';

class ValorantRepository{
  final ValorantAPI valorantAPI = ValorantAPI();

  Future<ChampionsResponse> getChampions() async{
    final String raw = await valorantAPI.getChampions();

    final ChampionsResponse championsResponse = ChampionsResponse.fromJson(jsonDecode(raw));

    List<Champion> champions = [];

    championsResponse.data?.forEach((champion) {
      if(champion.isPlayableCharacter == true){
        champions.add(champion);
      }
    });

    championsResponse.data = champions;

    return championsResponse;
  }
}