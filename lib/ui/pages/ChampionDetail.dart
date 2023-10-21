import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:valorant/business_logic/bloc/champion/champions_cubit.dart';
import 'package:valorant/data/models/champion/ChampionsResponse.dart';
import 'package:valorant/ui/components/Ability.dart';
import 'package:valorant/PaintTriangle.dart';

class ChampionDetail extends StatefulWidget {
  const ChampionDetail({Key? key}) : super(key: key);

  @override
  State<ChampionDetail> createState() => _ChampionDetailState();
}

class _ChampionDetailState extends State<ChampionDetail> {
  String _key = "C";
  var color_icons = {
    "C": Colors.white,
    "Q": Colors.white.withOpacity(.5),
    "E": Colors.white.withOpacity(.5),
    "X": Colors.white.withOpacity(.5)
  };
  void onAbilityPressed(String newKey) {
    setState(() {
      _key = newKey;
      color_icons["C"] = Colors.white.withOpacity(.5);
      color_icons["Q"] = Colors.white.withOpacity(.5);
      color_icons["E"] = Colors.white.withOpacity(.5);
      color_icons["X"] = Colors.white.withOpacity(.5);

      color_icons[_key] = Colors.white;
    });
  }

  late Champion champ;

  @override
  void initState() {
    super.initState();
    champ = BlocProvider.of<ChampionsCubit>(context).champ;
  }

  @override
  Widget build(BuildContext context) {
    String displayName = "";
    String description = "";

    switch (_key) {
      case "C":
        displayName = champ.abilities?[0].displayName ?? "";
        description = champ.abilities?[0].description ?? "";
        break;
      case "Q":
        displayName = champ.abilities?[1].displayName ?? "";
        description = champ.abilities?[1].description ?? "";
        break;
      case "E":
        displayName = champ.abilities?[2].displayName ?? "";
        description = champ.abilities?[2].description ?? "";
        break;
      case "X":
        displayName = champ.abilities?[3].displayName ?? "";
        description = champ.abilities?[3].description ?? "";
        break;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(int.parse(
            "0xFF${champ.backgroundGradientColors?[1].toString().substring(0, 6)}")),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            context.go('/champions');
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        toolbarHeight: 70,
        title: Center(
          child: Container(
            margin: const EdgeInsets.only(top: 0, right: 60),
            child: Text(
              champ.displayName?.toUpperCase() ?? "",
              style: const TextStyle(
                fontFamily: 'monument',
                fontSize: 28,
              ),
            ),
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 30, 30, 30),
      body: WillPopScope(
        onWillPop: () async{
          context.go('/champions');
          return false;
        },
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                CustomPaint(
                  size: const Size(300, 300),
                  painter: PaintTriangle(
                      backgroundColor: Color(int.parse(
                          "0xFF${champ?.backgroundGradientColors?[1].toString().substring(0, 6)}")),
                      screenWidth: MediaQuery.of(context).size.width),
                  child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(
                                champ?.background ?? ""),
                          )),
                      child: Image(
                        image: CachedNetworkImageProvider(
                            champ?.fullPortrait ?? ""),
                      )),
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: 50, left: 30),
                    child: Text(
                      "Description".toUpperCase(),
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontFamily: 'monument'),
                    )),
                Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(
                      top: 20,
                      left: 30,
                      right: 30,
                    ),
                    child: Text(
                      champ?.description ?? "",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontFamily: 'poppins'),
                    )),
                Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: 50, left: 30),
                    child: Text(
                      (champ?.role?.displayName ?? "").toUpperCase(),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontFamily: 'monument'),
                    )),
                Container(
                  margin: EdgeInsets.only(top: 20, right: 30, left: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          champ?.role?.description ?? "",
                          textAlign: TextAlign.left,
                          softWrap: true,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontFamily: 'poppins'),
                        ),
                      ),
                      Image(
                          width: 55,
                          height: 55,
                          image:
                          NetworkImage(champ?.role?.displayIcon ?? ""))
                    ],
                  ),
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: 50, left: 30),
                    child: Text(
                      "abilities".toUpperCase(),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontFamily: 'monument'),
                    )),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Ability(
                        image_url: champ?.abilities?[0].displayIcon,
                        keyAbility: "C",
                        onClick: onAbilityPressed,
                        actualKey: _key,
                        color_icon: color_icons["C"],
                      ),
                      Ability(
                        image_url: champ?.abilities?[1].displayIcon,
                        keyAbility: "Q",
                        onClick: onAbilityPressed,
                        actualKey: _key,
                        color_icon: color_icons["Q"],
                      ),
                      Ability(
                        image_url: champ?.abilities?[2].displayIcon,
                        keyAbility: "E",
                        onClick: onAbilityPressed,
                        actualKey: _key,
                        color_icon: color_icons["E"],
                      ),
                      Ability(
                        image_url: champ?.abilities?[3].displayIcon,
                        keyAbility: "X",
                        onClick: onAbilityPressed,
                        actualKey: _key,
                        color_icon: color_icons["X"],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(top: 20, left: 30),
                  child: Text(
                    displayName.toUpperCase(),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontFamily: 'monument'),
                  ),
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(
                        top: 20, left: 30, right: 30, bottom: 30),
                    child: Text(
                      description ,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontFamily: 'poppins'),
                    )),
              ],
            )),
      ),
    );
  }
}
