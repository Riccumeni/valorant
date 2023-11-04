import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorComponent extends StatelessWidget {
  final Function onRetryTapped;
  const ErrorComponent({super.key, required this.onRetryTapped});

  @override
  Widget build(BuildContext context) {
     return Column(
       mainAxisAlignment: MainAxisAlignment.center,
       crossAxisAlignment: CrossAxisAlignment.center,
      children:  [
        Icon(Icons.dangerous_outlined, color: Theme.of(context).colorScheme.error, size: 60,),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          child: const Text(
            "Something was wrong, check your internet connection",
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'monument',
                fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ),
        ElevatedButton(onPressed: () => onRetryTapped(), child: const Text("Retry",style: TextStyle(
            color: Colors.white,
            fontFamily: 'monument',
            fontSize: 14), ))
      ],
    );
  }
}
