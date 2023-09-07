import 'package:flutter/material.dart';

class PopButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const PopButton({super.key, 
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}