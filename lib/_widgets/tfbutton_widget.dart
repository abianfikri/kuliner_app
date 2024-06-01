import 'package:flutter/material.dart';

class TfButton extends StatefulWidget {
  const TfButton({
    super.key,
    required this.controller,
    required this.labelText,
    required this.validator,
    required this.maxLines,
    required this.onTap,
  });
  final TextEditingController controller;
  final String labelText;
  final String validator;
  final int maxLines;
  final VoidCallback onTap;

  @override
  State<TfButton> createState() => _TfButtonState();
}

class _TfButtonState extends State<TfButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: 350,
      child: TextFormField(
        controller: widget.controller,
        maxLines: widget.maxLines,
        decoration: InputDecoration(
          labelText: widget.labelText,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
        readOnly: true,
        validator: (value) {
          if (value!.isEmpty) {
            return widget.validator;
          }
          return null;
        },
        onTap: widget.onTap,
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }
}
