import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:valorant/data/models/skin/SkinResponse.dart';

import '../data_providers/ValorantAPI.dart';

class SkinRepository{
  ValorantAPI _api = ValorantAPI();

  Future<SkinResponse> getWeaponsFilteredByPreferences() async {
    final raw = await _api.getSkins();

    final response = SkinResponse.fromJson(jsonDecode(raw));

    List<Skin> filteredSkins = [];

    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> favs = prefs.getStringList("favs") ?? [];

    response.data?.forEach((element) {
        for(String fav in favs){
          if(fav == element.uuid){
            filteredSkins.add(element);
          }
        }
    });

    response.data = filteredSkins;

    return response;
  }
}