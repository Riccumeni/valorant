part of 'maps_cubit.dart';

abstract class MapsState {

}
class LoadingMapsState extends MapsState{}

class SuccessMapsState extends MapsState{
  MapsResponse? mapsResponse;
  SuccessMapsState({required this.mapsResponse});
}

class ErrorMapsState extends MapsState{}