import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(IsNotFavourite());

  Future<void> setPreference(String fav) async{
    try{
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      List<String> favs = prefs.getStringList("favs") ?? [];

      if(favs.isEmpty){
        await prefs.setStringList("favs", <String>[fav]);
        emit(IsFavourite());
      } else if(favs.isEmpty){
        await prefs.setStringList("favs", <String>[fav]);
        emit(IsFavourite());
      }else{
        bool isInFav = false;
        var index = -1;
        for (var element in favs) {
          if(element == fav){
            isInFav = true;
            index = favs.indexOf(element);
          }
        }

        if(isInFav){
          favs.removeAt(index);
          await prefs.setStringList("favs", favs);
          emit(IsNotFavourite());
        }else{
          favs.add(fav);
          await prefs.setStringList("favs", favs);
          emit(IsFavourite());
        }
      }
    }catch(e){
      var err = e;
    }
  }

  Future<void> getPreference(String fav) async{
    try{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> favs = prefs.getStringList("favs") ?? [];

      if(favs.isEmpty){
        await prefs.setStringList("favs", <String>[]);
        emit(IsNotFavourite());
      }else{
        bool isInFavs = false;
        for(var element in favs){
          if(element == fav){
            isInFavs = true;
          }
        }
        if(isInFavs){
          emit(IsFavourite());
        }else{
          emit(IsNotFavourite());
        }
      }
    }catch(e){}
  }
}