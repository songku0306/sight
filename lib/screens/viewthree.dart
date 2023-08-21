import 'package:flutter/material.dart';
import 'package:newviewprac/widgets/button.dart';
import 'package:newviewprac/widgets/typeMenu.dart';
import 'package:newviewprac/widgets/typeResult.dart';

class viewThree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(149, 97, 161, 1),
                Color.fromRGBO(18, 34, 89, 1)
              ],
            ),
          ),
          child: const Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Button(
                        text: 'click',
                        bgColor: Colors.white,
                        textColor: Colors.amber,
                      ),
                      Column(
                        children: [
                          typeMenu(name: 'last one', time: '12:35'),
                          SizedBox(
                            height: 10,
                          ),
                          typeMenu(name: 'last two', time: '2:39'),
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
