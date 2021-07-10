import 'package:flutter/material.dart';
import 'package:paint_board/provider/paint_provider.dart';
import 'package:paint_board/view/board.dart';
import 'package:paint_board/view/tool_bar.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PaintBoard',
      home: Scaffold(
        body: SafeArea(
          child: ChangeNotifierProvider<PaintProvider>(
            create: (context) => PaintProvider(),
            builder: (context, child) => Column(
              children: [
                child!,
                Flexible(
                  child: RepaintBoundary(
                    key: Provider.of<PaintProvider>(context, listen: false)
                        .captureKey,
                    child: Board(),
                  ),
                ),
              ],
            ),
            child: ToolBar(),
          ),
        ),
      ),
    );
  }
}
