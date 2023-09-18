import 'package:baynursingroom/data/api_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<NursingRoomInfo> nursingRoomList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(
        Uri.parse('http://apis.data.go.kr/6260000/BusanNursingroomInfoService'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final items = data['getNursingroomInfo']['body']['items']['item'];

      setState(() {
        nursingRoomList = items
            .map((item) => NursingRoomInfo(
                  sj: item['sj'],
                  address: item['address'],
                  tel: item['tel'],
                ))
            .toList();
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  void copyToClipboard(String address) {
    Clipboard.setData(ClipboardData(text: address));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('주소가 클립보드에 복사되었습니다.'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nursing Room App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Nursing Room List'),
        ),
        body: ListView.builder(
          itemCount: nursingRoomList.length,
          itemBuilder: (context, index) {
            final item = nursingRoomList[index];
            return ListTile(
              title: Text(item.sj),
              subtitle: Text(item.address),
              trailing: IconButton(
                icon: Icon(Icons.copy),
                onPressed: () {
                  copyToClipboard(item.address);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
