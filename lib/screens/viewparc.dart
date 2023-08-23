import 'package:flutter/material.dart';
import 'package:newviewprac/widgets/box_color.dart';

class ViewPrac extends StatelessWidget {
  const ViewPrac({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BoxColor(
                bgcolor: Colors.black12,
                ht: 30,
                wd: 30,
              ),
              SizedBox(
                width: 30,
              ),
              BoxColor(
                bgcolor: Colors.black26,
                ht: 30,
                wd: 30,
              )
            ],
          ),
          Row(
            children: [
              BoxColor(
                bgcolor: Colors.green,
                ht: 30,
                wd: 30,
              ),
              SizedBox(
                width: 30,
              ),
              BoxColor(
                bgcolor: Colors.green,
                ht: 30,
                wd: 30,
              )
            ],
          )
        ],
      ),
    );
  }
}
