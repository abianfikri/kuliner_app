import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
  const ButtonWidget(
      {super.key, required this.onPressed, required this.nameButton});
  final VoidCallback onPressed;
  final String nameButton;

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: widget.onPressed, child: Text(widget.nameButton));
  }
}
