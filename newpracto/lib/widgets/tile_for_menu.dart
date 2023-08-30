import 'package:flutter/material.dart';

class TileForMenu extends StatelessWidget {
  final double wd, ht;

  final Color colors;

  const TileForMenu({
    super.key,
    required this.wd,
    required this.ht,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: wd,
      height: ht,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: colors,
      ),
    );
  }
}
