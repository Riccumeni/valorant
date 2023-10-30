import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/map/MapsResponse.dart';
import '../../../data/repositories/MapsRepository.dart';

part 'maps_state.dart';

class MapsCubit extends Cubit<MapsState> {
  MapsCubit() : super(LoadingMapsState());

  MapsRepository repository = MapsRepository();

  late Maps maps;

  Future<void> getMaps() async {

    emit(LoadingMapsState());

    try{
      var mapsResponse = await repository.getMaps();
      emit(SuccessMapsState(mapsResponse: mapsResponse));
    }catch(e){
      print(e);
      emit(ErrorMapsState());
    }
  }

  void setMap (Maps tappedMap){
    maps = tappedMap;
  }
}
