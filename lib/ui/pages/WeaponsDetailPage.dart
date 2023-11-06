import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:valorant/business_logic/bloc/skins/skin_cubit.dart';
import 'package:valorant/business_logic/bloc/weapon/weapon_cubit.dart';
import 'package:valorant/data/models/weapons/WeaponsResponse.dart';
import 'package:valorant/ui/components/ProgressStat.dart';
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
  void initState() {
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
      skins.insert(
          0, Skin(displayName: weapon.displayName, uuid: weapon.uuid!));
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
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).colorScheme.onPrimaryContainer,),
        ),
        toolbarHeight: 64,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Center(
          child: Container(
            margin: const EdgeInsets.only(top: 0, right: 60),
            child: Text(
              weapon.displayName.toUpperCase() ?? "",
              style:  TextStyle(
                fontFamily: 'monument',
                fontSize: 28,
                color: Theme.of(context).colorScheme.onPrimaryContainer
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
                if (state is SkinsSuccess) {
                  newSkins = state.skinResponse.data;
                  return CarouselSlider(
                    items: newSkins.map((skin) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 320,
                            child: Image.network(
                                skin.chromas?[0].fullRender ??
                                    weapon.displayIcon,
                                fit: BoxFit.contain),
                          ),
                          SizedBox(
                            width: double.maxFinite,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    skin.displayName?.toUpperCase() ?? "",
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    style: const TextStyle(
                                        fontFamily: 'monument',
                                        fontSize: 16,
                                        color: Colors.white
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  if (newSkins.indexOf(skin) > 0)
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                            width: 50,
                                            child: InkWell(
                                              child: Icon(
                                                skin.isFavourite
                                                    ? Icons.favorite_outlined
                                                    : Icons.favorite_border,
                                                color: skin.isFavourite
                                                    ? Colors.red
                                                    : Colors.grey,
                                              ),
                                              onTap: () async {
                                                bool isFavourite =
                                                    skin.isFavourite;
                                                BlocProvider.of<SkinCubit>(
                                                        context)
                                                    .setPreference(newSkins,
                                                        skin.toJson());
                                              },
                                            )),
                                        InkWell(
                                          child: const Icon(
                                            Icons.info_outline,
                                            color: Colors.grey,
                                          ),
                                          onTap: () {
                                            var param1 = skin.uuid;
                                            context.push(
                                                '/skin-detail/${param1.toString()}');
                                          },
                                        )
                                      ],
                                    )
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                    options: CarouselOptions(
                      height: 460,
                      enlargeCenterPage: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      viewportFraction: 0.8,
                      onPageChanged: cycleImages,
                    ),
                  );
                } else {
                  return const SizedBox(
                    height: 320,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
              },
            ),
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
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:  [
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

                        ProgressStat(
                            category: "Reload Time Seconds",
                            value: weapon.weaponStats?.reloadTimeSeconds.toString() ?? "",
                            maxValue: 5.0
                        ),

                        const SizedBox(height: 20),

                        ProgressStat(
                            category: "Magazine Size",
                            value: weapon.weaponStats?.magazineSize.toString() ?? "",
                            maxValue: 100.0
                        ),

                        const SizedBox(height: 20),

                        if (weapon.weaponStats?.adsStats != null)
                          weapon.weaponStats!.adsStats?.zoomMultiplier != null ?
                          ProgressStat(
                              category: "Zoom Multiplier",
                              value: weapon.weaponStats?.adsStats?.zoomMultiplier.toString() ?? "",
                              maxValue: 3.5
                          ) : Text(""),

                          const SizedBox(height: 20),

                        weapon.weaponStats!.adsStats?.fireRate != null ?
                          ProgressStat(
                              category: "Fire Rate",
                              value: weapon.weaponStats?.adsStats?.fireRate.round().toString() ?? "",
                              maxValue: 16.0
                          ) : Text(""),

                          const SizedBox(height: 20),

                        weapon.weaponStats!.adsStats?.firstBulletAccuracy != null ?
                          ProgressStat(
                              category: "First Bullet Accuracy",
                              value: weapon.weaponStats?.firstBulletAccuracy.toString() ?? "",
                              maxValue: 5.0
                          ) : Text(""),
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
