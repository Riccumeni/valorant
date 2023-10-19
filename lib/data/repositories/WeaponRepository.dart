import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:valorant/data/data_providers/ValorantAPI.dart';

import '../models/weapons/WeaponsResponse.dart';

class WeaponRepository{
  ValorantAPI api = ValorantAPI();

  Future<WeaponsResponse> getWeapons() async {
    final raw = await api.getWeapons();

    final response = WeaponsResponse.fromJson(jsonDecode(raw));

    response.data?.forEach((weapon) {
      weapon.skins?.forEach((skin) async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        List<String> favs = prefs.getStringList("favs") ?? [];

        for (var fav in favs) {
          if (fav == skin.uuid) {
            skin.isFavourite = true;
          }
        }
      });
    });
    return response;
  }
}