import 'package:baybaby/widget/week_list.dart';
import 'package:flutter/material.dart';

class WeekTimeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Baby Care App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BabyCareScreen(),
    );
  }
}

class BabyCareScreen extends StatefulWidget {
  @override
  _BabyCareScreenState createState() => _BabyCareScreenState();
}

class _BabyCareScreenState extends State<BabyCareScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('위클리기록'),
        ),
        body: ShoppingApp());
  }
}
