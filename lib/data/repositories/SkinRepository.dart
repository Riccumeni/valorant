import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:valorant/data/models/skin/SkinResponse.dart';
import '../data_providers/ValorantAPI.dart';

class SkinRepository {
  ValorantAPI _api = ValorantAPI();

  Future<SkinsResponse> getWeaponsFilteredByPreferences() async {
    final raw = await _api.getSkins();

    final response = SkinsResponse.fromJson(jsonDecode(raw));

    List<Skin> filteredSkins = [];

    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> favs = prefs.getStringList("favs") ?? [];

    response.data?.forEach((element) {
      for (String fav in favs) {
        if (fav == element.uuid) {
          filteredSkins.add(element);
        }
      }
    });

    response.data = filteredSkins;

    return response;
  }

  Future<SkinResponse> getWeaponsFilteredByName(String name) async {
    final raw = await _api.getSkins();

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
  Future<SkinsResponse> getSkins() async {
    final raw = await _api.getSkins();

    final response = SkinsResponse.fromJson(jsonDecode(raw));

    List<Skin> skins = [];

    response.data?.forEach((skin) {
      skins.add(skin);
    });
    response.data = skins;
    return response;
  }

  Future<SkinResponse> getSkin(String id) async {
    final String raw = await _api.getSkin(id);

    final SkinResponse skinResponse = SkinResponse.fromJson(jsonDecode(raw));

    return skinResponse;
  }
}
