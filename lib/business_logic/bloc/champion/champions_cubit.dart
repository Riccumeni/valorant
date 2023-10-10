import 'package:bloc/bloc.dart';
import 'package:valorant/data/models/champion/ChampionsResponse.dart';
import 'package:valorant/data/repositories/ValorantRepository.dart';

part 'champions_state.dart';

class ChampionsCubit extends Cubit<ChampionsState> {
  ChampionsCubit() : super(LoadingChampionsState());

  ValorantRepository repository = ValorantRepository();

  List<Champion> response = [];

  Future<void> getChampions({text, category}) async {

    emit(LoadingChampionsState());

    try{
      ChampionsResponse championsResponse;

      if(response.isEmpty){
        championsResponse = await repository.getChampions();
        response = championsResponse.data!;
      }else{
        championsResponse = ChampionsResponse(status: 200, data: response);
      }

      if(text != null || category != null){
        var newChampionResponse = [];
        championsResponse.data!.forEach((champion){
          if((champion.role?.displayName.toLowerCase() == category.toString().toLowerCase()) || category.toString().toLowerCase() == "all"){
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
