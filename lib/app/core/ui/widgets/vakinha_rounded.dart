import 'package:flutter/material.dart';

class VakinhaButtonRounded extends StatelessWidget {
  final VoidCallback onPress;
  final String label;
  final double? fontSize;
  const VakinhaButtonRounded(
      {Key? key,
      required this.onPress,
      required this.label,
      this.fontSize = 25})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      child: Text(
        label,
        style: TextStyle(color: Colors.grey, fontSize: fontSize),
      ),
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        primary: Colors.white,
      ),
    );
  }
}
