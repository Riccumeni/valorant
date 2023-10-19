import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:valorant/data/models/map/MapsResponse.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MapDetail extends StatefulWidget {
  final Maps maps;
  const MapDetail({Key? key, required this.maps}) : super(key: key);

  @override
  State<MapDetail> createState() => _MapDetailState();
}

class _MapDetailState extends State<MapDetail> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Usa l'oggetto `maps` per visualizzare i dettagli delle mappe selezionate
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
              widget.maps.displayName.toUpperCase(),
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
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0),
              ), // Image border
              child: SizedBox.fromSize(
                size: const Size.fromRadius(200), // Image radius
                child: Image.network(
                  widget.maps.splash,
                  width: MediaQuery.of(context).size.width,
                  height: 420,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if( widget.maps.coordinates != null)
                  const SizedBox(height: 30),
                  if( widget.maps.coordinates != null)
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "COORDINATES",
                      style: TextStyle(
                        fontFamily: 'monument',
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  if( widget.maps.coordinates != null)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.maps.coordinates.toString(),
                      style: const TextStyle(
                        fontFamily: 'poppins',
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "DESCRIPTION",
                      style: TextStyle(
                        fontFamily: 'monument',
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "A mysterious structure housing an astral conduit radiates with ancient power. Great stone doors provide a variety of movement opportunities and unlock the paths to three mysterious sites.",
                    style: TextStyle(
                      fontFamily: 'poppins',
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30),
                  if (widget.maps.displayIcon != null)
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "MAP",
                      style: TextStyle(
                        fontFamily: 'monument',
                        fontSize: 24,
                        color: Colors.white,
                      ), // will align at leading-end of parent/containe
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (widget.maps.displayIcon != null)
                  Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationZ(
                      6.27 / 4,
                    ),
                    child: Image.network(
                      widget.maps.displayIcon,
                      width: 340,
                      height: 340,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 70),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
