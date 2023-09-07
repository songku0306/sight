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
        title: const Text('데일리기록'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                '수면',
                style: TextStyle(fontSize: 20, color: Colors.blue),
              ),
            ),
            const SizedBox(height: 30), // 30픽셀의 공간 추가
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                '분유',
                style: TextStyle(fontSize: 20, color: Colors.green),
              ),
            ),

            const SizedBox(height: 30), // 30픽셀의 공간 추가
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                '기저귀',
                style: TextStyle(fontSize: 20, color: Colors.red),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
