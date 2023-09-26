import 'dart:convert';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JSON Example',
      home: JsonExample(),
    );
  }
}

class JsonExample extends StatefulWidget {
  @override
  _JsonExampleState createState() => _JsonExampleState();
}

class _JsonExampleState extends State<JsonExample> {
  List<dynamic> jsonData = [];

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  Future<void> loadJsonData() async {
    // JSON 파일을 읽어와 jsonData에 저장
    final String jsonContent = await DefaultAssetBundle.of(context)
        .loadString('assets/data.json'); // assets 폴더에 있는 JSON 파일

    setState(() {
      jsonData = json.decode(jsonContent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('JSON Example'),
      ),
      body: ListView.builder(
        itemCount: jsonData.length,
        itemBuilder: (context, index) {
          final item = jsonData[index];
          return ListTile(
            title: Text(item['name']),
            subtitle: Text(item['description']),
          );
        },
      ),
    );
  }
}
