import 'dart:convert';
import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:valorant/data/models/skin/SkinResponse.dart';
import 'package:valorant/data/repositories/SkinRepository.dart';

import '../../../data/models/weapons/WeaponsResponse.dart';

part 'skin_state.dart';

class SkinCubit extends Cubit<SkinState> {
  SkinCubit() : super(SkinLoading());

  SkinRepository repository = SkinRepository();


  Future<void> getSkinsByFavourite() async {
    emit(SkinLoading());
    try{
      // SkinResponse response = await repository.getWeaponsFilteredByPreferences();
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      List<String> rawFavs = prefs.getStringList("favs") ?? [];
      List<Skin> favs = [];

      for(String rawFav in rawFavs){
        favs.add(Skin.fromJson(jsonDecode(rawFav)));
      }
      emit(SkinSuccess(skinResponse: SkinResponse(status: 200, data: favs)));
    }catch(e){
      emit(SkinError());
    }
  }

  Future<void> getSkinsByWeapon(List<Skins> skins) async {

    emit(SkinLoading());
    try{
      List<Skin> newSkins = [];
      for (var element in skins) {
        newSkins.add(element.toSkin());
      }
      emit(SkinSuccess(skinResponse: SkinResponse(status: 200, data: newSkins)));
    }catch(e){
      emit(SkinError());
    }
  }

  Future<void> setPreference(List<Skin> skins, Map<String, dynamic> fav) async{
    try{
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      List<String> rawFavs = prefs.getStringList("favs") ?? [];
      List<Map<String, dynamic>> favs = [];

      for(String rawFav in rawFavs){
        favs.add(jsonDecode(rawFav));
      }

      if(favs.isEmpty){
        await prefs.setStringList("favs", <String>[jsonEncode(fav)]);
        skins.forEach((element) {
          if(element.uuid == fav['uuid']) {
            element.isFavourite = true;
          }
        });
      }else{
        bool isInFav = false;
        var index = -1;
        for (var element in favs) {
          if(element['uuid'] == fav['uuid']){
            isInFav = true;
            index = favs.indexOf(element);
          }
        }

        if(isInFav){
          favs.removeAt(index);
          for (var skin in skins) {
            if(skin.uuid == fav['uuid']) {
              skin.isFavourite = !skin.isFavourite;
            }
          }
          rawFavs = [];
          for(Map<String, dynamic> fav in favs){
            rawFavs.add(jsonEncode(fav));
          }
          await prefs.setStringList("favs", rawFavs);
          emit(SkinSuccess(skinResponse: SkinResponse(status: 200, data: skins)));
        }else{
          favs.add(fav);
          for (var skin in skins) {
            if(skin.uuid == fav['uuid']) {
              skin.isFavourite = !skin.isFavourite;
            }
          }
          rawFavs = [];
          for(Map<String, dynamic> fav in favs){
            rawFavs.add(jsonEncode(fav));
          }
          await prefs.setStringList("favs", rawFavs);
          emit(SkinSuccess(skinResponse: SkinResponse(status: 200, data: skins)));
        }
      }
    }catch(e){
      var err = e;
    }
  }

  Future<void> removeSkinByFavourite(SkinResponse skins, String uuid) async{

    emit(SkinLoading());

    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();

      List<String> skinFavs = prefs.getStringList("favs") ?? [];

      bool isFound = false;

      int index = -1;

      for (int i = 0; i < skinFavs.length; i++){
        String skinFav = skinFavs[i];
        if(uuid == skinFav){
          index = i;
          // skinFavs.remove(skinFav);
        }
      }

      if(index != -1){
        skinFavs.removeAt(index);
      }

      index = -1;

      for(int i= 0; i < skins.data!.length; i++){
        if(uuid == skins.data![i].uuid){
          // skins.data!.remove(skin);
          index = i;
        }
      }

      if(index != -1){
        skins.data!.removeAt(index);
      }

      prefs.setStringList("favs", skinFavs);

      emit(SkinSuccess(skinResponse: skins));

    }catch(e){
      emit(SkinError());
    }
  }
}
