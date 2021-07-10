import 'package:flutter/material.dart';
import 'package:paint_board/model/line_info.dart';

class Painter extends CustomPainter {
  final List<LineInfo> lines;
  Painter(this.lines);

  @override
  void paint(Canvas canvas, Size size) {
    var pen = Paint()
      ..color = Colors.black
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    var erase = Paint()
      ..color = Colors.white
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    for (var oneLine in lines) {
      var p = Path();

      p.addPolygon(oneLine.points, false);

      canvas.drawPath(
        p,
        oneLine.mode == 'PEN' ? pen : erase,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
