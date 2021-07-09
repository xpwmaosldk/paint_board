import 'package:flutter/material.dart';

class Painter extends CustomPainter {
  Painter(this.lines);
  final List<List<Offset>> lines;
  @override
  void paint(Canvas canvas, Size size) {
    for (var oneLine in lines) {
      var p = Path();

      p.addPolygon(oneLine, false);

      canvas.drawPath(
        p,
        Paint()
          ..color = Colors.black
          ..strokeWidth = 10
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
