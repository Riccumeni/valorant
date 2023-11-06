import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final String destination;
  bool rotate;

  HomeCard({super.key, required this.title, required this.description, required this.imageUrl, required this.destination, this.rotate = false});

  @override
  Widget build(BuildContext context) {

    var elements = [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'monument',
              fontSize: 22,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            description,
            style: const TextStyle(
              fontFamily: 'poppins',
              fontSize: 10,
              color: Colors.white,
            ),
          )
        ],
      ),
      Image.asset(
        imageUrl,
        height: 145,
        width: 165,
      )
    ];

    if(rotate == true){
      elements.reversed;
    }

    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(left: rotate ? 0 : 20, top: 10, right: rotate ? 20 : 0),
        padding: const EdgeInsets.only(left: 20),
        width: 388.84,
        height: 194.93,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(rotate ? "./assets/vectorLeft.png" : "./assets/vectorRight.png"))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
             ...elements
          ],
        ),
      ),
      onTap: (){
        context.push(destination);
      },
    );
  }
}
