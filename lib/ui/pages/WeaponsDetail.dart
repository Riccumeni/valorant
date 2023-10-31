import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:valorant/business_logic/bloc/skins/skin_cubit.dart';
import 'package:valorant/business_logic/bloc/weapon/weapon_cubit.dart';
import 'package:valorant/data/models/weapons/WeaponsResponse.dart';

import '../../data/models/skin/SkinResponse.dart';

class WeaponDetail extends StatefulWidget {
  const WeaponDetail({Key? key}) : super(key: key);

  @override
  _WeaponDetailState createState() => _WeaponDetailState();
}

class _WeaponDetailState extends State<WeaponDetail> {
  int currentIndex = 0;
  bool isRunning = true;
  String state = 'Animation start';

  late Weapon weapon;

  void cycleImages(int index, CarouselPageChangedReason reason) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    weapon = BlocProvider.of<WeaponCubit>(context).weapon;
    List<Skin>? skins = weapon.skins;
    skins?.removeWhere((skin) =>
    skin.displayName == "Random Favorite Skin" ||
        skin.displayName == "Standard ${weapon.displayName}");

    bool isDisplayNamePresent = false;

    for (var skin in skins!) {
      if (skin.displayName == weapon.displayName) {
        isDisplayNamePresent = true;
      }
    }

    if (!isDisplayNamePresent) {
      skins.insert(0, Skin(displayName: weapon.displayName, uuid: weapon.uuid!));
    }
    weapon.skins = skins;
    BlocProvider.of<SkinCubit>(context).getSkinsByWeapon(weapon.skins!);
  }

  @override
  Widget build(BuildContext context) {

    bool range1 = weapon.weaponStats?.damageRanges?.length == 1;
    bool range2 = weapon.weaponStats?.damageRanges?.length == 2;
    bool range3 = weapon.weaponStats?.damageRanges?.length == 3;

    double percent(double valoreAttuale, double valoreMax) {
      double x = (valoreAttuale * 100) / valoreMax;
      return x;
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 30, 30),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        toolbarHeight: 64,
        backgroundColor: const Color.fromARGB(255, 38, 38, 38),
        title: Center(
          child: Container(
            margin: const EdgeInsets.only(top: 0, right: 60),
            child: Text(
              weapon.displayName?.toUpperCase() ?? "",
              style: const TextStyle(
                fontFamily: 'monument',
                fontSize: 28,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BlocBuilder<SkinCubit, SkinState>(
              builder: (context, state) {
                List<Skin> newSkins = [];
                if (state is SkinSuccess) {
                  newSkins = state.skinResponse.data;
                  //BlocProvider.of<SkinCubit>(context).getSkinsByWeapon(newSkins);
                  return CarouselSlider(
                    items: newSkins.map((skin) {
                      return Container(
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                skin.displayIcon ?? weapon.displayIcon),
                            fit: BoxFit.contain,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 180),
                          child: SizedBox(
                            width: double.maxFinite,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    skin.displayName?.toUpperCase() ?? "",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontFamily: 'monument',
                                        fontSize: 16,
                                        color: Colors.white),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  InkWell(
                                    child: Icon(
                                      skin.isFavourite
                                          ? Icons.favorite_outlined
                                          : Icons.favorite_border,
                                      color: skin.isFavourite
                                          ? Colors.red
                                          : Colors.grey,
                                    ),
                                    onTap: () async {
                                      bool isFavourite = skin.isFavourite;
                                      BlocProvider.of<SkinCubit>(context).setPreference(newSkins, skin.toJson());
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    options: CarouselOptions(
                      height: 390,
                      enlargeCenterPage: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      viewportFraction: 0.8,
                      onPageChanged: cycleImages,
                    ),
                  );
                }else{
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

              },
            ),
            const SizedBox(height: 50),
            if (weapon.shopData?.category != null)
              const Text(
                "INFORMATION",
                style: TextStyle(
                  fontFamily: 'monument',
                  fontSize: 28,
                  color: Colors.white,
                ),
              ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (weapon.shopData?.category != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "CATEGORY",
                                style: TextStyle(
                                  fontFamily: 'monument',
                                  fontSize: 24,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                weapon.shopData?.category ?? "",
                                style: const TextStyle(
                                  fontFamily: 'poppins',
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),

                      if (weapon.shopData?.cost != null)
                        Column(
                          children: [
                            Row(
                              children: [
                                const Text(
                                  " ¤ ",
                                  style: TextStyle(
                                    fontFamily: 'monument',
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  weapon.shopData?.cost.toString() ?? "",
                                  style: const TextStyle(
                                    fontFamily: 'monument',
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                    ],
                  ),
                  if (range1 || range2 || range3)
                    Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            SizedBox(height: 25),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "DAMAGE",
                                style: TextStyle(
                                  fontFamily: 'monument',
                                  fontSize: 24,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10),
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Range",
                                    style: TextStyle(
                                      fontFamily: 'monument',
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                if (range1 || range2 || range3)
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "${weapon.weaponStats?.damageRanges?[0].rangeStartMeters}-${weapon.weaponStats?.damageRanges?[0].rangeEndMeters}m",
                                        style: const TextStyle(
                                          fontFamily: 'monument',
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      )),
                                const SizedBox(height: 15),
                                if (range2 || range3)
                                  Text(
                                    "${weapon.weaponStats?.damageRanges?[0].rangeStartMeters}-${weapon.weaponStats?.damageRanges?[0].rangeEndMeters}m",
                                    style: const TextStyle(
                                      fontFamily: 'monument',
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                const SizedBox(height: 15),
                                if (range3)
                                  Text(
                                    "${weapon.weaponStats?.damageRanges?[0].rangeStartMeters}-${weapon.weaponStats?.damageRanges?[0].rangeEndMeters}m",
                                    style: const TextStyle(
                                      fontFamily: 'monument',
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(width: 30),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10),
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Head",
                                    style: TextStyle(
                                      fontFamily: 'monument',
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                if (range1 || range2 || range3)
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      weapon.weaponStats?.damageRanges?[0]
                                              .headDamage
                                              .round()
                                              .toString() ??
                                          "",
                                      style: const TextStyle(
                                        fontFamily: 'monument',
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                const SizedBox(height: 15),
                                if (range2 || range3)
                                  Text(
                                    weapon.weaponStats?.damageRanges?[1]
                                            .headDamage
                                            .round()
                                            .toString() ??
                                        "",
                                    style: const TextStyle(
                                      fontFamily: 'monument',
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                const SizedBox(height: 15),
                                if (range3)
                                  Text(
                                    weapon.weaponStats?.damageRanges?[2]
                                            .headDamage
                                            .round()
                                            .toString() ??
                                        "",
                                    style: const TextStyle(
                                      fontFamily: 'monument',
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(width: 27),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10),
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Body",
                                    style: TextStyle(
                                      fontFamily: 'monument',
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                if (range1 || range2 || range3)
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      weapon.weaponStats?.damageRanges?[0]
                                              .bodyDamage
                                              .round()
                                              .toString() ??
                                          "",
                                      style: const TextStyle(
                                        fontFamily: 'monument',
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                const SizedBox(height: 15),
                                if (range2 || range3)
                                  Text(
                                    weapon.weaponStats?.damageRanges?[1]
                                            .bodyDamage
                                            .round()
                                            .toString() ??
                                        "",
                                    style: const TextStyle(
                                      fontFamily: 'monument',
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                const SizedBox(height: 15),
                                if (range3)
                                  Text(
                                    weapon.weaponStats?.damageRanges?[2]
                                            .bodyDamage
                                            .round()
                                            .toString() ??
                                        "",
                                    style: const TextStyle(
                                      fontFamily: 'monument',
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(width: 27),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10),
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Leg",
                                    style: TextStyle(
                                      fontFamily: 'monument',
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                if (range1 || range2 || range3)
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      weapon.weaponStats?.damageRanges?[0]
                                              .legDamage
                                              .round()
                                              .toString() ??
                                          "",
                                      style: const TextStyle(
                                        fontFamily: 'monument',
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                const SizedBox(height: 15),
                                if (range2 || range3)
                                  Text(
                                    weapon.weaponStats?.damageRanges?[1]
                                            .legDamage
                                            .round()
                                            .toString() ??
                                        "",
                                    style: const TextStyle(
                                      fontFamily: 'monument',
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                const SizedBox(height: 15),
                                if (range3)
                                  Text(
                                    weapon.weaponStats?.damageRanges?[2]
                                            .legDamage
                                            .round()
                                            .toString() ??
                                        "",
                                    style: const TextStyle(
                                      fontFamily: 'monument',
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                const SizedBox(height: 15),
                              ],
                            ),
                          ],
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "STATISTICS",
                            style: TextStyle(
                              fontFamily: 'monument',
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Reload Time Seconds: ",
                                style: TextStyle(
                                  fontFamily: 'monument',
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Text(
                              weapon.weaponStats?.reloadTimeSeconds
                                      .toString() ??
                                  "",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'poppins',
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        LinearPercentIndicator(
                          padding: const EdgeInsets.all(0),
                          backgroundColor: Colors.grey,
                          lineHeight: 15,
                          center: Text(
                              weapon.weaponStats?.reloadTimeSeconds
                                      .toString() ??
                                  "",
                              style: const TextStyle(fontSize: 11)),
                          progressColor: Colors.white,
                          barRadius: const Radius.circular(10),
                          percent: percent(
                                  double.parse(weapon
                                          .weaponStats?.reloadTimeSeconds
                                          .toString() ??
                                      ""),
                                  5.0) /
                              100,
                          animation: true,
                          animationDuration: 1000,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Magazine Size: ",
                                style: TextStyle(
                                  fontFamily: 'monument',
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Text(
                              weapon.weaponStats?.magazineSize.toString() ?? "",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'poppins',
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        LinearPercentIndicator(
                          padding: const EdgeInsets.all(0),
                          backgroundColor: Colors.grey,
                          lineHeight: 15,
                          center: Text(
                              weapon.weaponStats?.magazineSize.toString() ?? "",
                              style: const TextStyle(fontSize: 11)),
                          progressColor: Colors.white,
                          barRadius: const Radius.circular(10),
                          percent: percent(
                                  double.parse(weapon.weaponStats?.magazineSize
                                          .toString() ??
                                      ""),
                                  100.0) /
                              100,
                          animation: true,
                          animationDuration: 1000,
                        ),
                        const SizedBox(height: 20),
                        if (weapon.weaponStats?.adsStats != null)
                          Row(
                            children: [
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Zoom Multiplier: ",
                                  style: TextStyle(
                                    fontFamily: 'monument',
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Text(
                                weapon.weaponStats?.adsStats?.zoomMultiplier
                                        .toString() ??
                                    "",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'poppins',
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        const SizedBox(height: 10),
                        if (weapon.weaponStats?.adsStats != null)
                          LinearPercentIndicator(
                            padding: const EdgeInsets.all(0),
                            backgroundColor: Colors.grey,
                            lineHeight: 15,
                            center: Text(
                                weapon.weaponStats?.adsStats?.zoomMultiplier
                                        .toString() ??
                                    "",
                                style: const TextStyle(fontSize: 11)),
                            progressColor: Colors.white,
                            barRadius: const Radius.circular(10),
                            percent: percent(
                                    double.parse(weapon.weaponStats?.adsStats
                                            ?.zoomMultiplier
                                            .toString() ??
                                        ""),
                                    3.5) /
                                100,
                            animation: true,
                            animationDuration: 1000,
                          ),
                        const SizedBox(height: 20),
                        if (weapon.weaponStats?.adsStats != null)
                          Row(
                            children: [
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Fire Rate: ",
                                  style: TextStyle(
                                    fontFamily: 'monument',
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Text(
                                weapon.weaponStats?.adsStats?.fireRate
                                        .round()
                                        .toString() ??
                                    "",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'poppins',
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        const SizedBox(height: 10),
                        if (weapon.weaponStats?.adsStats != null)
                          LinearPercentIndicator(
                            padding: const EdgeInsets.all(0),
                            backgroundColor: Colors.grey,
                            lineHeight: 15,
                            center: Text(
                                weapon.weaponStats?.adsStats?.fireRate
                                        .round()
                                        .toString() ??
                                    "",
                                style: const TextStyle(fontSize: 11)),
                            progressColor: Colors.white,
                            barRadius: const Radius.circular(10),
                            percent: percent(
                                    double.parse(weapon
                                            .weaponStats?.adsStats?.fireRate
                                            .round()
                                            .toString() ??
                                        ""),
                                    16.0) /
                                100,
                            animation: true,
                            animationDuration: 1000,
                          ),
                        const SizedBox(height: 20),
                        if (weapon.weaponStats?.adsStats != null)
                          Row(
                            children: [
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "First Bullet Accuracy: ",
                                  style: TextStyle(
                                    fontFamily: 'monument',
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Text(
                                weapon.weaponStats?.firstBulletAccuracy
                                        .toString() ??
                                    "",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'poppins',
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        const SizedBox(height: 10),
                        if (weapon.weaponStats?.adsStats != null)
                          LinearPercentIndicator(
                            padding: const EdgeInsets.all(0),
                            backgroundColor: Colors.grey,
                            lineHeight: 15,
                            center: Text(
                                weapon.weaponStats?.firstBulletAccuracy
                                        .toString() ??
                                    "",
                                style: const TextStyle(fontSize: 11)),
                            progressColor: Colors.white,
                            barRadius: const Radius.circular(10),
                            percent: percent(
                                    double.parse(
                                      weapon.weaponStats?.firstBulletAccuracy
                                              .toString() ??
                                          "",
                                    ),
                                    5.0) /
                                100,
                            animation: true,
                            animationDuration: 1000,
                          ),
                      ],
                    ),
                  const SizedBox(height: 25),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
