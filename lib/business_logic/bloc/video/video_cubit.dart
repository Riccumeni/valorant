import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'video_state.dart';

class VideoCubit extends Cubit<VideoState> {
  VideoCubit() : super(VideoInitial());

  CustomVideoPlayerController? customVideoPlayerController;

  Future<void> setVideo(context, url)async {
    emit(VideoLoading());
    try{
      if (url.isEmpty) throw Error();
      const settings = CustomVideoPlayerSettings(showSeekButtons: true);

      VideoPlayerController videoPlayerController = VideoPlayerController.network(url)..initialize();

      if(customVideoPlayerController == null){
        customVideoPlayerController = CustomVideoPlayerController(context: context, videoPlayerController: videoPlayerController, customVideoPlayerSettings: settings);
      }else{
        customVideoPlayerController?.dispose();
        customVideoPlayerController = CustomVideoPlayerController(context: context, videoPlayerController: videoPlayerController, customVideoPlayerSettings: settings);
      }

      Future.delayed(Duration(seconds: 1), (){
        emit(VideoSuccess(videoPlayerController: customVideoPlayerController!));
      });


    }catch(e){
      if(url == null || url.isEmpty){
        emit(VideoEmpty());
      }else{
        emit(VideoError());
      }
    }

  }
}
