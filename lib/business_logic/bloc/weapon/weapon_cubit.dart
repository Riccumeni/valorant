import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:valorant/data/models/weapons/WeaponsResponse.dart';
import 'package:valorant/data/repositories/WeaponRepository.dart';

part 'weapon_state.dart';

class WeaponCubit extends Cubit<WeaponState> {
  WeaponCubit() : super(WeaponsLoading());

  WeaponRepository repository = WeaponRepository();

  late Weapon weapon;

  WeaponsResponse? weapons;

  Future<void> getWeapons() async {
    emit(WeaponsLoading());

    try{

      late WeaponsResponse response;

      if(weapons == null){
        response = await repository.getWeapons();
        weapons = response;
        if(response.status != 200) throw Error();
      }else{
        response = weapons!;
      }

      emit(WeaponsSuccess(response: weapons ?? response));
    }catch(e){
      emit(WeaponsError());
    }
  }

  void setWeapon (Weapon tappedWeapon){
    weapon = tappedWeapon;
  }
}
