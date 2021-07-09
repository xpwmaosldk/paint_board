import 'package:flutter/material.dart';
import 'package:paint_board/custom/painter.dart';
import 'package:paint_board/provider/paint_provider.dart';
import 'package:provider/provider.dart';

class Board extends StatelessWidget {
  Board({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var p = Provider.of<PaintProvider>(context);
    return Stack(
      children: [
        if (p.backgroundImageData != null) Image.memory(p.backgroundImageData!),
        CustomPaint(
          painter: Painter(p.lines),
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onPanStart: (event) {
              if (p.eraseMode) {
                p.erase(event.localPosition);
              } else {
                p.drawStart(event.localPosition);
              }
            },
            onPanUpdate: (event) {
              if (p.eraseMode) {
                p.erase(event.localPosition);
              } else {
                if (p.outOfRange && event.localPosition.dy > 0) {
                  p.outOfRange = false;
                  p.drawStart(event.localPosition);
                }

                if (event.localPosition.dy > 0) {
                  p.drawing(event.localPosition);
                } else {
                  p.outOfRange = true;
                }
              }
            },
          ),
        ),
      ],
    );
  }
}
