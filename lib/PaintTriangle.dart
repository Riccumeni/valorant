import 'package:flutter/cupertino.dart';

class PaintTriangle extends CustomPainter {
  final Color backgroundColor;
  final screenWidth;

  PaintTriangle({
    required this.backgroundColor,
    required this.screenWidth
  });

  @override
  void paint(Canvas canvas, Size size) {
    final y = size.height;
    final x = size.width;

    final paint = Paint()
      ..color = backgroundColor;
    final path = Path();

    path
      ..moveTo(0, 0)
      ..lineTo(screenWidth, 0)
      ..lineTo(screenWidth, y);


    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}