// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:newviewprac/widgets/button.dart';
import 'package:newviewprac/widgets/typeMenu.dart';
import 'package:newviewprac/widgets/typeResult.dart';

class ViewDouble extends StatelessWidget {
  const ViewDouble({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 207, 196, 158),
          ),
          child: const Scaffold(
            backgroundColor: Colors.transparent,
            body: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text('1'),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          Text('2'),
                          SizedBox(
                            height: 10,
                          ),
                          Text('3'),
                          SizedBox(
                            height: 10,
                          ),
                          Text('4'),
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('5'),
                        SizedBox(
                          height: 10,
                        ),
                        Text('6'),
                        SizedBox(
                          height: 10,
                        ),
                        Text('7'),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
