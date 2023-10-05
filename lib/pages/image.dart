import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselSliderExampl extends StatefulWidget {
  final Map weapons;

  const CarouselSliderExampl({Key? key, required this.weapons})
      : super(key: key);

  @override
  _CarouselSliderExampleState createState() => _CarouselSliderExampleState();
}

class _CarouselSliderExampleState extends State<CarouselSliderExampl> {
  int currentIndex = 0;

  void cycleImages(int index, CarouselPageChangedReason reason) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> skins = widget.weapons["skins"];
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
      body:
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
                  padding: EdgeInsets.only(top: 180),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        skin["displayName"].toUpperCase(),
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

      );
  }
}
