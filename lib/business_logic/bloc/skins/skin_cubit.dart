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
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      List<String> rawFavs = prefs.getStringList("favs") ?? [];

      if(rawFavs.length == 0){
        emit(SkinEmpty());
        return;
      }

      List<Skin> favs = [];

      for(String rawFav in rawFavs){
        favs.add(Skin.fromJson(jsonDecode(rawFav)));
      }
      emit(SkinSuccess(skinResponse: SkinResponse(status: 200, data: favs)));
    }catch(e){
      emit(SkinError());
    }
  }

  Future<void> getSkinsByWeapon(List<Skin> skins) async {

    emit(SkinLoading());
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> favsRaw = prefs.getStringList("favs") ?? [];
      List<Map<String, dynamic>> favs = [];

      for(String favRaw in favsRaw){
        favs.add(jsonDecode(favRaw));
      }

      List<Skin> newSkins = [];
      for (var element in skins) {
        if(favs.isNotEmpty){
          for(Map<String, dynamic> fav in favs){
            if(element.uuid == fav['uuid']){
              element.isFavourite = true;
            }else{
              element.isFavourite = false;
            }
          }
        }else{
          element.isFavourite = false;
        }

        newSkins.add(element);
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
        for (Skin element in skins) {
          if(element.uuid == fav['uuid']) {
            element.isFavourite = true;
          }
          emit(SkinSuccess(skinResponse: SkinResponse(status: 200, data: skins)));
        }
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
      emit(SkinError());
    }
  }

  Future<void> removeSkinByFavourite(SkinResponse skins, String uuid) async{

    emit(SkinLoading());

    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();

      List<String> skinFavs = prefs.getStringList("favs") ?? [];

      List<Map<String, dynamic>> favs = [];

      skinFavs.forEach((element) {
        favs.add(jsonDecode(element));
      });

      bool isFound = false;

      int index = -1;

      for (int i = 0; i < favs.length; i++){
        Map<String, dynamic> skinFav = favs[i];
        if(uuid == skinFav['uuid']){
          index = i;
          // skinFavs.remove(skinFav);
        }
      }

      if(index != -1){
        favs.removeAt(index);
      }

      index = -1;

      for(int i= 0; i < skins.data!.length; i++){
        if(uuid == skins.data![i].uuid){
          // skins.data!.remove(skin);
          index = i;
        }
      }

      if(index != -1){
        skins.data![index].isFavourite = !skins.data![index].isFavourite;
        skins.data!.removeAt(index);
      }

      skinFavs = [];

      for(Map<String, dynamic> fav in favs){
        skinFavs.add(jsonEncode(fav));
      }

      prefs.setStringList("favs", skinFavs);

      if(skinFavs.isEmpty){
        emit(SkinEmpty());
      }else{
        emit(SkinSuccess(skinResponse: skins));
      }



    }catch(e){
      emit(SkinError());
    }
  }
}
