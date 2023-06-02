import 'package:flutter/material.dart';
import 'package:valorant/pages/Maps.dart';

Map<int, Color> color =
{
  50:Color.fromRGBO(30, 30, 30, .1),
  100:Color.fromRGBO(30, 30, 30, .2),
  200:Color.fromRGBO(30, 30, 30, .3),
  300:Color.fromRGBO(30, 30, 30, .4),
  400:Color.fromRGBO(30, 30, 30, .5),
  500:Color.fromRGBO(30, 30, 30, .6),
  600:Color.fromRGBO(30, 30, 30, .7),
  700:Color.fromRGBO(30, 30, 30, .8),
  800:Color.fromRGBO(30, 30, 30, .9),
  900:Color.fromRGBO(30, 30, 30, 1),
};

MaterialColor colorCustom = MaterialColor(0x1E1E1E, color);

void main()  {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: colorCustom,
      ),
      home: const MapsPage(),
    );
  }
}
