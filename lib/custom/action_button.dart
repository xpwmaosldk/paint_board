import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback? onPressed;

  const ActionButton({Key? key, this.text = '', this.icon, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
        minimumSize: MaterialStateProperty.all(Size(48, 48)),
      ),
      child: Row(
        children: [
          if (icon != null) Icon(icon),
          if (text.isNotEmpty) Text(text),
        ],
      ),
    );
  }
}
