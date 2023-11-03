import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorComponent extends StatelessWidget {
  const ErrorComponent({super.key});

  @override
  Widget build(BuildContext context) {
     return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:  [
        Icon(Icons.dangerous_outlined, color: Theme.of(context).colorScheme.error, size: 60,),
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: const Text(
            "Something was wrong, check your internet connection",
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'monument',
                fontSize: 14),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );;
  }
}
