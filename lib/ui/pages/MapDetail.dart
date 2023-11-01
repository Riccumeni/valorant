import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:valorant/data/models/map/MapsResponse.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../business_logic/bloc/map/maps_cubit.dart';

class MapDetail extends StatefulWidget {

  const MapDetail({Key? key}) : super(key: key);

  @override
  State<MapDetail> createState() => _MapDetailState();
}

class _MapDetailState extends State<MapDetail> {

  late Maps map;
  @override
  void initState() {
    super.initState();
    map =  BlocProvider.of<MapsCubit>(context).maps;
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
            context.pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        toolbarHeight: 100,
        title: Center(
          child: Container(
            margin: const EdgeInsets.only(top: 0, right: 60),
            child: Text(
              map.displayName.toUpperCase(),
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
                  map.splash,
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
                  const SizedBox(height: 30),
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
                  if( map.coordinates != null)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      map.coordinates.toString(),
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
                  Text(
                    map.narrativeDescription ?? "",
                    style: const TextStyle(
                      fontFamily: 'poppins',
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30),
                  if (map.displayIcon != null)
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
                  if (map.displayIcon != null)
                  Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationZ(
                      6.27 / 4,
                    ),
                    child: Image.network(
                      map.displayIcon,
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
