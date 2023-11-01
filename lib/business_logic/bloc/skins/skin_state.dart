part of 'skin_cubit.dart';

@immutable
abstract class SkinState {}

class SkinError extends SkinState {}

class SkinLoading extends SkinState {}

class SkinsSuccess extends SkinState{
  final skinResponse;
  SkinsSuccess({required this.skinResponse});
}

class SkinSuccess extends SkinState{
  final skinResponse;
  SkinSuccess({required this.skinResponse});
}

class SkinEmpty extends SkinState{}
