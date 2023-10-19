part of 'weapon_cubit.dart';

@immutable
abstract class WeaponState {}

class WeaponsError extends WeaponState{}

class WeaponsLoading extends WeaponState{}

class WeaponsSuccess extends WeaponState{
  WeaponsResponse response;

  WeaponsSuccess({required this.response});
}

