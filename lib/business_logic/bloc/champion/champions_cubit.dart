import 'package:bloc/bloc.dart';
import 'package:valorant/data/models/champion/ChampionsResponse.dart';
import 'package:valorant/data/repositories/ValorantRepository.dart';

part 'champions_state.dart';

class ChampionsCubit extends Cubit<ChampionsState> {
  ChampionsCubit() : super(LoadingChampionsState());

  ValorantRepository repository = ValorantRepository();

  Future<void> getChampions() async {

    emit(LoadingChampionsState());

    try{
      var championsResponse = await repository.getChampions();
      emit(SuccessChampionsState(championsResponse: championsResponse));
    }catch(e){
      emit(ErrorChampionsState());
    }
  }
}
