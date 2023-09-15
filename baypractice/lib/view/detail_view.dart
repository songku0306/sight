import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class DrawingArea {
  Offset point;
  Paint areaPaint;

  DrawingArea({required this.point, required this.areaPaint});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drawing App',
      home: DrawingApp(),
    );
  }
}

class DrawingApp extends StatefulWidget {
  @override
  _DrawingAppState createState() => _DrawingAppState();
}

class _DrawingAppState extends State<DrawingApp> {
  List<DrawingArea> points = [];
  Color selectedColor = Colors.black;
  double strokeWidth = 2.0;

  void selectColor() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('색상 선택'),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: selectedColor,
              onColorChanged: (color) {
                setState(() {
                  selectedColor = color;
                });
              },
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('그림 그리기 앱'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.color_lens),
            onPressed: selectColor,
          ),
        ],
      ),
      body: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            RenderBox renderBox = context.findRenderObject() as RenderBox;
            points.add(DrawingArea(
              point: renderBox.globalToLocal(details.globalPosition),
              areaPaint: Paint()
                ..strokeCap = StrokeCap.round
                ..isAntiAlias = true
                ..color = selectedColor
                ..strokeWidth = strokeWidth,
            ));
          });
        },
        onPanEnd: (details) {
          points.add(DrawingArea(
            point: null!,
            areaPaint: Paint(),
          ));
        },
        child: SizedBox.expand(
          child: CustomPaint(
            painter: MyCustomPainter(points: points),
          ),
        ),
      ),
    );
  }
}

class MyCustomPainter extends CustomPainter {
  List<DrawingArea> points;

  MyCustomPainter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i].point != null && points[i + 1].point != null) {
        canvas.drawLine(
          points[i].point,
          points[i + 1].point,
          points[i].areaPaint,
        );
      } else if (points[i].point != null && points[i + 1].point == null) {
        canvas.drawPoints(
          PointMode.points,
          [points[i].point],
          points[i].areaPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
