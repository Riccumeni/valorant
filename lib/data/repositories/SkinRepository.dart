import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:valorant/data/models/skin/SkinResponse.dart';
import '../data_providers/ValorantAPI.dart';

class SkinRepository {
  ValorantAPI _api = ValorantAPI();

  Future<SkinsResponse> getWeaponsFilteredByPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> favs = prefs.getStringList("favs") ?? [];

    List<Skin> skins = [];

    favs.forEach((element) {
      skins.add(Skin.fromJson(jsonDecode(element)));
    });

    return SkinsResponse(status: 200, data: skins);
  }

  Future<SkinsResponse> getWeaponsFilteredByName(String name) async {
    final raw = await _api.getSkins();

    final response = SkinsResponse.fromJson(jsonDecode(raw));

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
