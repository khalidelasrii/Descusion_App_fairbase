import 'package:flutter/material.dart';

class Mybuton extends StatelessWidget {
  const Mybuton(
      {super.key,
      required this.color,
      required this.onPressed,
      required this.title});
  final Color color;
  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 6,
      color: color,
      borderRadius: BorderRadius.circular(8),
      child: MaterialButton(
        onPressed: () => onPressed,
        minWidth: 350,
        height: 42,
        child: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
