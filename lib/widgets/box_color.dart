import 'package:flutter/material.dart';

class BoxColor extends StatelessWidget {
  final Color bgcolor;
  final double ht;
  final double wd;

  const BoxColor(
      {super.key, required this.bgcolor, required this.ht, required this.wd});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgcolor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: SizedBox(
        height: ht,
        width: wd,
      ),
    );
  }
}
