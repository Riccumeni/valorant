import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CarouselSliderExample extends StatefulWidget {
  final Map weapons;

  const CarouselSliderExample({Key? key, required this.weapons})
      : super(key: key);

  @override
  _CarouselSliderExampleState createState() => _CarouselSliderExampleState();
}

class _CarouselSliderExampleState extends State<CarouselSliderExample> {
  int currentIndex = 0;
  bool isRunning = true;
  String state = 'Animation start';

  void cycleImages(int index, CarouselPageChangedReason reason) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> skins = widget.weapons["skins"];
    skins.removeWhere((skin) =>
        skin["displayName"] == "Random Favorite Skin" ||
        skin["displayName"] == "Standard ${widget.weapons["displayName"]}");

    bool isDisplayNamePresent = false;

    for (var skin in skins) {
      if (skin["displayName"] == widget.weapons["displayName"]) {
        isDisplayNamePresent = true;
      }
    }

    if (!isDisplayNamePresent) {
      skins.insert(
        0,
        {
          "displayName": widget.weapons["displayName"],
        },
      );
    }
    bool range1 = widget.weapons["weaponStats"]?["damageRanges"].length == 1;
    bool range2 = widget.weapons["weaponStats"]?["damageRanges"].length == 2;
    bool range3 = widget.weapons["weaponStats"]?["damageRanges"].length == 3;

    double percent(double ValoreAttuale, double ValoreMax) {
      double x = (ValoreAttuale * 100) / ValoreMax;
      return x;
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 30, 30),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 30, 30, 30),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        toolbarHeight: 100,
        title: Center(
          child: Container(
            margin: const EdgeInsets.only(top: 0, right: 60),
            child: Text(
              widget.weapons["displayName"].toUpperCase(),
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
            CarouselSlider(
              items: skins.map((skin) {
                return Container(
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          skin["displayIcon"] ?? widget.weapons["displayIcon"]),
                      fit: BoxFit.contain,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 180),
                    child: SizedBox(
                      width: double.maxFinite,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          skin["displayName"].toUpperCase(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontFamily: 'monument',
                              fontSize: 16,

                              color: Colors.white),
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
            ),
            const SizedBox(height: 50),
            if (widget.weapons["shopData"]?["category"] != null)
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
                      if (widget.weapons["shopData"]?["category"] != null)
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
                                widget.weapons["shopData"]?["category"],
                                style: const TextStyle(
                                  fontFamily: 'poppins',
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(width: 55),
                      if (widget.weapons["shopData"]?["cost"] != null)
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
                                  widget.weapons["shopData"]["cost"].toString(),
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
                                        "${widget.weapons["weaponStats"]["damageRanges"][0]["rangeStartMeters"]}-${widget.weapons["weaponStats"]["damageRanges"][0]["rangeEndMeters"]}m",
                                        style: const TextStyle(
                                          fontFamily: 'monument',
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      )),
                                const SizedBox(height: 15),
                                if (range2 || range3)
                                  Text(
                                    "${widget.weapons["weaponStats"]["damageRanges"][1]["rangeStartMeters"]}-${widget.weapons["weaponStats"]["damageRanges"][1]["rangeEndMeters"]}m",
                                    style: const TextStyle(
                                      fontFamily: 'monument',
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                const SizedBox(height: 15),
                                if (range3)
                                  Text(
                                    "${widget.weapons["weaponStats"]["damageRanges"][2]["rangeStartMeters"]}-${widget.weapons["weaponStats"]["damageRanges"][2]["rangeEndMeters"]}m",
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
                                      widget.weapons["weaponStats"]["damageRanges"][0]["headDamage"].round().toString(),
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
                                    widget.weapons["weaponStats"]
                                            ["damageRanges"][1]["headDamage"]
                                        .round()
                                        .toString(),
                                    style: const TextStyle(
                                      fontFamily: 'monument',
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                const SizedBox(height: 15),
                                if (range3)
                                  Text(
                                    widget.weapons["weaponStats"]
                                            ["damageRanges"][2]["headDamage"]
                                        .round()
                                        .toString(),
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
                                      widget.weapons["weaponStats"]
                                              ["damageRanges"][0]["bodyDamage"]
                                          .round()
                                          .toString(),
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
                                    widget.weapons["weaponStats"]
                                            ["damageRanges"][1]["bodyDamage"]
                                        .round()
                                        .toString(),
                                    style: const TextStyle(
                                      fontFamily: 'monument',
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                const SizedBox(height: 15),
                                if (range3)
                                  Text(
                                    widget.weapons["weaponStats"]
                                            ["damageRanges"][2]["bodyDamage"]
                                        .round()
                                        .toString(),
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
                                      widget.weapons["weaponStats"]
                                              ["damageRanges"][0]["legDamage"]
                                          .round()
                                          .toString(),
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
                                    widget.weapons["weaponStats"]
                                            ["damageRanges"][1]["legDamage"]
                                        .round()
                                        .toString(),
                                    style: const TextStyle(
                                      fontFamily: 'monument',
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                const SizedBox(height: 15),
                                if (range3)
                                  Text(
                                    widget.weapons["weaponStats"]
                                            ["damageRanges"][2]["legDamage"]
                                        .round()
                                        .toString(),
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
                              widget.weapons["weaponStats"]["reloadTimeSeconds"]
                                  .toString(),
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
                              widget.weapons["weaponStats"]["reloadTimeSeconds"]
                                  .toString(),
                              style: const TextStyle(fontSize: 11)),
                          progressColor: Colors.white,
                          barRadius: const Radius.circular(10),
                          percent: percent(
                              double.parse(widget.weapons["weaponStats"]
                              ["reloadTimeSeconds"]
                                  .toString()),
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
                              widget.weapons["weaponStats"]["magazineSize"]
                                  .toString(),
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
                              widget.weapons["weaponStats"]["magazineSize"]
                                  .toString(),
                              style: const TextStyle(fontSize: 11)),
                          progressColor: Colors.white,
                          barRadius: const Radius.circular(10),
                          percent: percent(
                              double.parse(widget.weapons["weaponStats"]
                              ["magazineSize"]
                                  .toString()),
                              100.0) /
                              100,
                          animation: true,
                          animationDuration: 1000,
                        ),
                        const SizedBox(height: 20),
                        if (widget.weapons["weaponStats"]["adsStats"] != null)
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
                                widget.weapons["weaponStats"]["adsStats"]
                                        ["zoomMultiplier"]
                                    .toString(),
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
                        if (widget.weapons["weaponStats"]["adsStats"] != null)
                          LinearPercentIndicator(
                            padding: const EdgeInsets.all(0),
                            backgroundColor: Colors.grey,
                            lineHeight: 15,
                            center: Text(
                                widget.weapons["weaponStats"]["adsStats"]
                                        ["zoomMultiplier"]
                                    .toString(),
                                style: const TextStyle(fontSize: 11)),
                            progressColor: Colors.white,
                            barRadius: const Radius.circular(10),
                            percent: percent(
                                    double.parse(widget.weapons["weaponStats"]
                                            ["adsStats"]["zoomMultiplier"]
                                        .toString()),
                                    3.5) /
                                100,
                            animation: true,
                            animationDuration: 1000,
                          ),
                        const SizedBox(height: 20),
                        if (widget.weapons["weaponStats"]["adsStats"] != null)
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
                                widget.weapons["weaponStats"]["adsStats"]
                                        ["fireRate"]
                                    .round()
                                    .toString(),
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
                        if (widget.weapons["weaponStats"]["adsStats"] != null)
                          LinearPercentIndicator(
                            padding: const EdgeInsets.all(0),
                            backgroundColor: Colors.grey,
                            lineHeight: 15,
                            center: Text(
                                widget.weapons["weaponStats"]["adsStats"]
                                        ["fireRate"]
                                    .round()
                                    .toString(),
                                style: const TextStyle(fontSize: 11)),
                            progressColor: Colors.white,
                            barRadius: const Radius.circular(10),
                            percent: percent(
                                    double.parse(widget.weapons["weaponStats"]
                                            ["adsStats"]["fireRate"]
                                        .round()
                                        .toString()),
                                    16.0) /
                                100,
                            animation: true,
                            animationDuration: 1000,
                          ),
                        const SizedBox(height: 20),
                        if (widget.weapons["weaponStats"]["adsStats"] != null)
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
                                widget.weapons["weaponStats"]
                                        ["firstBulletAccuracy"]
                                    .toString(),
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
                        if (widget.weapons["weaponStats"]["adsStats"] != null)
                          LinearPercentIndicator(
                            padding: const EdgeInsets.all(0),
                            backgroundColor: Colors.grey,
                            lineHeight: 15,
                            center: Text(
                                widget.weapons["weaponStats"]
                                        ["firstBulletAccuracy"]
                                    .toString(),
                                style: const TextStyle(fontSize: 11)),
                            progressColor: Colors.white,
                            barRadius: const Radius.circular(10),
                            percent: percent(
                                    double.parse(widget.weapons["weaponStats"]
                                            ["firstBulletAccuracy"]
                                        .toString()),
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
