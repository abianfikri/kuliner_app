import 'package:flutter/material.dart';

class TfWidget extends StatefulWidget {
  const TfWidget(
      {super.key,
      required this.controller,
      required this.textInputType,
      required this.hintText,
      required this.labelText,
      required this.validator,
      required this.maxLines});

  final TextEditingController controller;
  final TextInputType textInputType;
  final String hintText;
  final String labelText;
  final String validator;
  final int maxLines;

  @override
  State<TfWidget> createState() => _TfWidgetState();
}

class _TfWidgetState extends State<TfWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: 350,
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.textInputType,
        maxLines: widget.maxLines,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          hintText: widget.hintText,
          labelText: widget.labelText,
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return widget.validator;
          }
          return null;
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }
}
