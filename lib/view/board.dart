import 'package:flutter/material.dart';
import 'package:paint_board/custom/painter.dart';
import 'package:paint_board/provider/paint_provider.dart';
import 'package:provider/provider.dart';

class Board extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var p = Provider.of<PaintProvider>(context);
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          if (p.loadImageData != null) Image.memory(p.loadImageData!),
          if (p.backgroundImageData != null)
            Image.memory(p.backgroundImageData!),
          CustomPaint(
            painter: Painter(p.lines),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onPanStart: (event) => p.drawStart(event.localPosition),
              onPanUpdate: (event) => p.drawing(event.localPosition),
            ),
          ),
        ],
      ),
    );
  }
}
