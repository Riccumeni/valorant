import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key, required this.title});
  final String title;

  @override
  State<MapsPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MapsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 30, 30, 30),
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 40),
                  width: MediaQuery.of(context).size.width,
                  height: 140,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                        opacity: 0.7,
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            "https://media.valorant-api.com/maps/7eaecc1b-4337-bbf6-6ab9-04b8f06b3319/splash.png",
                          ))),
                  child: const Text(
                    "ASCENT",
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.white,

                    ),
                  )
              )
            ],
          ),
        ));
  }
}
