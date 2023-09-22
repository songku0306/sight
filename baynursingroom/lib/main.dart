import 'package:baynursingroom/fornew/providers/nursing_room_provider.dart';
import 'package:baynursingroom/fornew/screens/nursing_room_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NursingRoomProvider(),
      child: MaterialApp(
        title: 'Nursing Room App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: NursingRoomListScreen(),
      ),
    );
  }
}
