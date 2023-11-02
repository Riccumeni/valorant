part of 'video_cubit.dart';

@immutable
abstract class VideoState {}

class VideoInitial extends VideoState {}

class VideoSuccess extends VideoState {
  final CustomVideoPlayerController videoPlayerController;

  VideoSuccess({required this.videoPlayerController});
}

class VideoLoading extends VideoState {}

class VideoError extends VideoState {}

class VideoEmpty extends VideoState{}
