import 'package:flutter/material.dart';

class BoxColor extends StatefulWidget {
  final Color bgcolor;
  final double ht;
  final double wd;

  const BoxColor(
      {super.key, required this.bgcolor, required this.ht, required this.wd});

  @override
  State<BoxColor> createState() => _BoxColorState();
}

class _BoxColorState extends State<BoxColor> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.bgcolor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: SizedBox(
        height: widget.ht,
        width: widget.wd,
        child: widget,
      ),
    );
  }
}
