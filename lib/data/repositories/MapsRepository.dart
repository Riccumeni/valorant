import 'dart:convert';
import 'dart:ffi';

import 'package:valorant/data/data_providers/ValorantAPI.dart';

import '../models/map/MapsResponse.dart';

class MapsRepository{
  final ValorantAPI valorantAPI = ValorantAPI();

  Future<MapsResponse> getMaps() async{
    final String raw = await valorantAPI.getMaps();

    final MapsResponse mapsResponse = MapsResponse.fromJson(jsonDecode(raw));

    List<Maps> maps = [];

    mapsResponse.data?.forEach((map) {

        maps.add(map);

    });

    mapsResponse.data = maps;

    return mapsResponse;

  }
}