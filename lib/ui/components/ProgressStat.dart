import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProgressStat extends StatelessWidget {
  final String category;
  final String value;
  final double maxValue;

  const ProgressStat({super.key, required this.category, required this.value, required this.maxValue});

  double percent(double presentValue, double maxValue) {
    double x = (presentValue * 100) / maxValue;
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$category: $value",
          style: const TextStyle(
            fontFamily: 'monument',
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        LinearPercentIndicator(
          padding: const EdgeInsets.all(0),
          backgroundColor: Colors.grey,
          lineHeight: 15,
          progressColor: Colors.white,
          barRadius: const Radius.circular(10),
          percent: percent(
              double.parse(value
                  .toString()),
              maxValue) /
              100,
          animation: true,
          animationDuration: 1000,
        ),
      ],
    );
  }
}
