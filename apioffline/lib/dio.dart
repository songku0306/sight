import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


void main() {
  runApp(NpractApp());
}

class NpractApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nursing Room App',
      home: NursingScreen(),
    );
  }
}

class NursingScreen extends StatefulWidget {
  @override
  _NursingScreenState createState() => _NursingScreenState();
}

class _NursingScreenState extends State<NursingScreen> {
  Future<List<dynamic>> fetchData() async {
    String data = await rootBundle.loadString(assets/data.svc);
    List<dynamic> jsonData = json.decode(data);
    return jsonData;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('place :'),
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('서버 데이터 리스트'),
        ),
        body: FutureBuilder<List<dynamic>>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('데이터를 불러오는 중에 오류가 발생했습니다: ${snapshot.error}');
            } else {
              // 가져온 데이터를 활용하여 UI 리스트를 구성합니다.
              List? data = snapshot.data;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(data[index]['title']),
                    subtitle: Text(data[index]['subtitle']),
                    // 원하는 데이터 필드를 가져와서 표시할 수 있습니다.
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
