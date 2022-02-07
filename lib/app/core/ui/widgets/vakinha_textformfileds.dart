import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VakinhaTextFormField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChange;

  const VakinhaTextFormField({
    Key? key,
    required this.label,
    this.controller,
    this.obscureText = false,
    this.validator,
    this.onChange,
  }) : super(key: key);

  borderText() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(23),
      borderSide: BorderSide(color: Colors.grey[400]!),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      onChanged: onChange,
      cursorColor: context.theme.primaryColor,
      decoration: InputDecoration(
        isDense: true,
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black),
        errorStyle: const TextStyle(color: Colors.redAccent),
        border: borderText(),
        enabledBorder: borderText(),
        focusedBorder: borderText(),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
