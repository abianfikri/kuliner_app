import 'package:flutter/material.dart';

class TFPrefixIconWidget extends StatelessWidget {
  const TFPrefixIconWidget(
      {super.key,
      required this.controller,
      required this.textInputType,
      required this.hintText,
      required this.labelText,
      required this.validator,
      required this.maxLines,
      required this.prefixIcon});
  final TextEditingController controller;
  final TextInputType textInputType;
  final String hintText;
  final String labelText;
  final String validator;
  final int maxLines;
  final Icon prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: 350,
      child: TextFormField(
        controller: controller,
        keyboardType: textInputType,
        maxLines: maxLines,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          hintText: hintText,
          labelText: labelText,
          prefixIcon: prefixIcon,
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return validator;
          }
          return null;
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }
}
