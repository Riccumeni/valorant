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

  Future<SkinResponse> getWeaponsFilteredByName(String name) async {
    final raw = await _api.getSkins();

    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();

    final response = SkinResponse.fromJson(jsonDecode(raw));

    List<Skin> filteredSkins = [];

    response.data?.forEach((element) {
      final regex = RegExp(name);
      if(regex.hasMatch(element.displayName!)){
        filteredSkins.add(element);
      }
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> favs = prefs.getStringList("favs") ?? [];

    filteredSkins.forEach((element) {
      for(String fav in favs){
        if(fav == element.uuid){
          element.isFavourite = !element.isFavourite;
        }
      }
    });

    response.data = filteredSkins;

    return response;
  }
}