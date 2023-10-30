import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:valorant/data/models/skin/SkinResponse.dart';
import 'package:valorant/data/repositories/SkinRepository.dart';

part 'skin_state.dart';

class SkinCubit extends Cubit<SkinState> {
  SkinCubit() : super(SkinLoading());

  SkinRepository repository = SkinRepository();

  Future<void> getSkins() async {

    emit(SkinLoading());

    try{
      SkinsResponse response = await repository.getSkins();
      emit(SkinSuccess(skinResponse: response));
    }catch(e){
      emit(SkinError());
    }
  }

  late Skin skin;
  Future<void> getSkin(String id) async {

    emit(SkinLoading());

    try{
      SkinResponse response = await repository.getSkin(id);
      emit(SkinSuccess(skinResponse: response));
    }catch(e){
      emit(SkinError());
    }
  }void setSkin (Skin tappedSkin){
    skin = tappedSkin;
  }


  Future<void> getSkinsByFavourite() async {
    emit(SkinLoading());

    try{
      SkinsResponse response = await repository.getWeaponsFilteredByPreferences();
      emit(SkinSuccess(skinResponse: response));
    }catch(e){
      emit(SkinError());
    }
  }

  Future<void> removeSkinByFavourite(SkinsResponse skins, String uuid) async{

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
