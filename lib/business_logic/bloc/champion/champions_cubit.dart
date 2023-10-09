import 'package:bloc/bloc.dart';
import 'package:valorant/data/models/champion/ChampionsResponse.dart';
import 'package:valorant/data/repositories/ValorantRepository.dart';

part 'champions_state.dart';

class ChampionsCubit extends Cubit<ChampionsState> {
  ChampionsCubit() : super(LoadingChampionsState());

  ValorantRepository repository = ValorantRepository();

  Future<void> getChampions({text, category}) async {

    emit(LoadingChampionsState());

    if(category == "all"){
      category = null;
    }

    try{
      var championsResponse = await repository.getChampions();

      if(text != null || category != null){
        var newChampionResponse = [];
        championsResponse.data!.forEach((champion){
          if(champion.role?.displayName.toLowerCase() == category.toString().toLowerCase()){
            if(text != null){
              RegExp pattern = RegExp("^$text");
              if(pattern.hasMatch(champion.displayName?.toLowerCase() ?? "")){
                newChampionResponse.add(champion);
              }
            }else{
              newChampionResponse.add(champion);
            }
          }
        });
        championsResponse.data = newChampionResponse.cast<Champion>();
      }

      emit(SuccessChampionsState(championsResponse: championsResponse));
    }catch(e){
      emit(ErrorChampionsState());
    }
  }
}
