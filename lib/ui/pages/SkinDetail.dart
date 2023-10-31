import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:valorant/business_logic/bloc/skins/skin_cubit.dart';
import 'package:valorant/data/models/skin/SkinResponse.dart';

class SkinDetail extends StatefulWidget {
  String id;
  SkinDetail({super.key, required this.id});

  @override
  _SkinDetailState createState() => _SkinDetailState();
}

class _SkinDetailState extends State<SkinDetail> {
  List<VideoPlayerController> _videoPlayerControllers = [];
  List<CustomVideoPlayerController>? _customVideoPlayerControllers = [];
  late CustomVideoPlayerWebController _customVideoPlayerWebController;

  final CustomVideoPlayerSettings _customVideoPlayerSettings =
  const CustomVideoPlayerSettings(showSeekButtons: true);

  int selectedChromaIndex = 0;
  int selectedLevelsIndex = 0;

  bool isOnPress = false;
  void onPress() {
    setState(() {
      if (isOnPress == false) {
        isOnPress = true;
      } else if (isOnPress == true) {
        isOnPress = false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SkinCubit>(context).getSkin(widget.id).then((value) => {

      for(Levels level in BlocProvider.of<SkinCubit>(context).skin.levels!){
        if(level.streamedVideo != null){
          _videoPlayerControllers.add(VideoPlayerController.network(
            level.streamedVideo!,
          )..initialize().then((value) => setState(() {}))),
        }
      },

      for(VideoPlayerController videoController in _videoPlayerControllers){
        _customVideoPlayerControllers?.add(CustomVideoPlayerController(
          context: context,
          videoPlayerController: videoController,
          customVideoPlayerSettings: _customVideoPlayerSettings,
        ))
      }

    });

  }

  @override
  void dispose() {
    for(CustomVideoPlayerController controller in _customVideoPlayerControllers!){
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 30, 30),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            context.go('/weapon-detail');
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        toolbarHeight: 64,
        backgroundColor: const Color.fromARGB(255, 38, 38, 38),
        title: Center(
          child: Container(
            margin: const EdgeInsets.only(top: 0, right: 60),
            child: const Text(
              "SKIN DETAIL",
              style: TextStyle(
                fontFamily: 'monument',
                fontSize: 28,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: BlocBuilder<SkinCubit, SkinState>(
          builder: (context, state) {
            if (state is SkinLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SkinSuccess) {
              var skin = state.skinResponse.data;
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 120),
                      child: SizedBox(
                        width: double.maxFinite,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                  height: 150,
                                  child: Image.network(skin
                                      .chromas[selectedChromaIndex]
                                      .fullRender ??
                                      '')
                                      .animate()
                                      .fade(begin: 0, end: 1, duration: 1000.ms)
                                //.scale(delay: 500.ms),
                              ),
                              const SizedBox(
                                height: 90,
                              ),
                              Text(
                                skin.chromas[selectedChromaIndex].displayName
                                    .toUpperCase() ??
                                    "",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontFamily: 'monument',
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              if (skin.chromas[selectedChromaIndex].swatch !=
                                  null)
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 35, bottom: 30, top: 35),
                                  alignment: Alignment.centerLeft,
                                  child: const Text(
                                    "Chromes",
                                    style: TextStyle(
                                      fontFamily: 'monument',
                                      fontSize: 22,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  for (int i = 0; i < skin.chromas.length; i++)
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedChromaIndex = i;
                                          isOnPress = true;
                                        });
                                      },
                                      child: Container(
                                        height: 74,
                                        child: Column(
                                          children: [
                                            if (skin.chromas[i].swatch != null)
                                              Image.network(
                                                skin.chromas[i].swatch ?? '',
                                                width: 50,
                                                height: 50,
                                              ),
                                            if (isOnPress &&
                                                selectedChromaIndex == i)
                                              const Icon(Icons.horizontal_rule,
                                                  color: Colors.white)
                                                  .animate()
                                                  .fade(
                                                  begin: 0,
                                                  end: 1,
                                                  duration: 1000.ms),
                                            if (skin.chromas[i].swatch !=
                                                null &&
                                                i == 0 &&
                                                !isOnPress)
                                              const Icon(Icons.horizontal_rule,
                                                  color: Colors.white),
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              for (int i = 0; i < _videoPlayerControllers.length; i++)
                                SizedBox(
                                  width: double.maxFinite,
                                  height: 330,
                                  child: Column(
                                    children: [
                                      _customVideoPlayerControllers?[i] != null
                                          ? CustomVideoPlayer(
                                        customVideoPlayerController:
                                        _customVideoPlayerControllers![i],
                                      ) : Text(""),
                                      Container(
                                        margin: EdgeInsets.only(top: 30),
                                        child: Text(
                                          skin.levels[i].displayName,
                                          style: const TextStyle(
                                            fontFamily: 'monument',
                                            fontSize: 22,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}