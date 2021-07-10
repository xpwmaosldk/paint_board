import 'package:flutter/material.dart';
import 'package:paint_board/custom/action_button.dart';
import 'package:paint_board/provider/paint_provider.dart';
import 'package:provider/provider.dart';

class ToolBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var p = Provider.of<PaintProvider>(context);
    var isLargeScreen = MediaQuery.of(context).size.width > 600;

    return Container(
      color: Colors.black12,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Row(
        mainAxisAlignment: isLargeScreen
            ? MainAxisAlignment.start
            : MainAxisAlignment.spaceAround,
        children: [
          ActionButton(
            text: 'SAVE',
            onPressed: p.save,
          ),
          ActionButton(
            text: 'LOAD',
            onPressed: p.load,
          ),
          if (isLargeScreen)
            Flexible(
              child: Container(),
            ),
          ActionButton(
            text: 'ADD',
            onPressed: p.add,
          ),
          if (isLargeScreen)
            Flexible(
              flex: 5,
              child: Container(),
            ),
          ActionButton(
            icon: Icons.arrow_back,
            onPressed: p.back,
          ),
          ActionButton(
            icon: Icons.arrow_forward,
            onPressed: p.forward,
          ),
          if (isLargeScreen)
            Flexible(
              child: Container(),
            ),
          ActionButton(
            text: 'PEN',
            onPressed: () => p.changeMode('PEN'),
          ),
          ActionButton(
            text: 'ERASE',
            onPressed: () => p.changeMode('ERASE'),
          ),
        ],
      ),
    );
  }
}
