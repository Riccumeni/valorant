part of 'champions_cubit.dart';

class ChampionsState{

}

class LoadingChampionsState extends ChampionsState{}

class SuccessChampionsState extends ChampionsState{
  ChampionsResponse? championsResponse;
  SuccessChampionsState({required this.championsResponse});
}

class SuccessChampionState extends ChampionsState{
  ChampionResponse? championResponse;
  SuccessChampionState({required this.championResponse});
}

class ErrorChampionsState extends ChampionsState{}
