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
    map = BlocProvider.of<MapsCubit>(context).maps;
    print(map.displayIcon);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
        toolbarHeight: 70,
        title: Center(
          child: Container(
            margin: const EdgeInsets.only(top: 0, right: 60),
            child: Text(
              map.displayName.toUpperCase(),
              style: TextStyle(
                  fontFamily: 'monument',
                  fontSize: 28,
                  color: Theme.of(context).colorScheme.onPrimaryContainer),
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
                  if (map.coordinates != "unknown")
                    Container(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: const Align(
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
                    ),
                  if (map.coordinates != "unknown")
                    Container(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          map.coordinates?.toString() ?? '',
                          style: const TextStyle(
                            fontFamily: 'poppins',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  if (map.narrativeDescription != "")
                    Container(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: const Align(
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
                    ),
                  const SizedBox(height: 5),
                  if (map.narrativeDescription != "")
                    Container(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        map.narrativeDescription ?? "",
                        style: const TextStyle(
                          fontFamily: 'poppins',
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  if (map.displayIcon != "")
                    Container(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: const Align(
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
                    ),
                  if (map.displayIcon != "")
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationZ(
                        6.27 / 4,
                      ),
                      child: Image.network(
                        map.displayIcon,
                        width: 340,
                        height: 340,
                        fit: BoxFit.fill,
                      ),
                    ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
