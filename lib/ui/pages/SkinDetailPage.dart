import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:valorant/business_logic/bloc/skins/skin_cubit.dart';
import 'package:valorant/business_logic/bloc/video/video_cubit.dart';
import 'package:valorant/ui/themes/Colors.dart';

class SkinDetail extends StatefulWidget {
  String id;
  SkinDetail({super.key, required this.id});

  @override
  _SkinDetailState createState() => _SkinDetailState();
}

class _SkinDetailState extends State<SkinDetail> {
  CustomVideoPlayerController? _customVideoPlayerController;
  final CustomVideoPlayerSettings _customVideoPlayerSettings =
  const CustomVideoPlayerSettings(showSeekButtons: true);

  int selectedChromaIndex = 0;
  int selectedLevelsIndex = 0;
  int selectedVideoIndex = 0;

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
    BlocProvider.of<VideoCubit>(context).setVideo(context, BlocProvider.of<SkinCubit>(context).skin.levels![selectedVideoIndex].streamedVideo)
    });
  }

  @override
  void dispose() {
    _customVideoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 70,
        backgroundColor: const Color.fromARGB(255, 38, 38, 38),
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Center(
          child: Container(
            margin: const EdgeInsets.only(top: 30, right: 60),
            child: SvgPicture.asset(
              "./assets/valorant-logo.svg",
              width: 70,
              height: 70,
            ),
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 30, 30, 30),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: BlocBuilder<SkinCubit, SkinState>(
          builder: (context, state) {
            if (state is SkinLoading) {
              return Center(child: CircularProgressIndicator(color: ColorsTheme.valorant,));
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
                                BlocBuilder<VideoCubit, VideoState>(

                                    builder: (context, state){
                                    if(state is VideoSuccess){
                                      return Container(
                                        height: 250,
                                        child: CustomVideoPlayer(
                                          customVideoPlayerController: state.videoPlayerController,
                                        ),
                                      );
                                    } else if(state is VideoLoading){
                                      return SizedBox(
                                        height: 250,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            color: ColorsTheme.valorant,
                                          ),
                                        ),
                                      );
                                    }else if(state is VideoError){
                                      return Text("Error loading video");
                                    }else{
                                      return SizedBox();
                                    }
                                  }
                                ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  if(skin.levels.isNotEmpty && skin.levels[0].streamedVideo != null )
                                    for (int i = 0; i < skin.levels.length; i++)
                                      InkWell(
                                        onTap: (){
                                          setState(() {
                                            selectedVideoIndex = i;
                                            _customVideoPlayerController?.dispose();
                                            BlocProvider.of<VideoCubit>(context).setVideo(context, skin.levels[selectedVideoIndex].streamedVideo);
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            color: selectedVideoIndex == i ? Colors.white : Colors.grey.shade600,
                                          ),
                                          padding: EdgeInsets.all(5),
                                          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                          width: 50,
                                          height: 30,
                                          child: Center(
                                            child: Text(
                                              (i + 1).toString(),
                                              style: TextStyle(
                                                fontFamily: 'monument',
                                                fontSize: 18,
                                                color: selectedVideoIndex == i ? Colors.black : Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                  ],
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