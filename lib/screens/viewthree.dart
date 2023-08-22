// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:newviewprac/widgets/button.dart';
import 'package:newviewprac/widgets/typeMenu.dart';
import 'package:newviewprac/widgets/typeResult.dart';

class viewThree extends StatelessWidget {
  const viewThree({super.key});

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
            body: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Button(
                        text: 'click',
                        bgColor: Colors.white,
                        textColor: Colors.amber,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          typeMenu(name: 'last sleep', time: '12:35'),
                          SizedBox(
                            height: 10,
                          ),
                          typeMenu(name: 'last diper', time: '2:39'),
                          SizedBox(
                            height: 10,
                          ),
                          typeMenu(name: 'last Three', time: '6:11'),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      typeResult(name: 'last one', time: '12:39'),
                      SizedBox(
                        height: 10,
                      ),
                      typeResult(name: 'last two', time: '2:39'),
                      SizedBox(
                        height: 10,
                      ),
                      typeResult(name: 'last two', time: '2:39'),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
