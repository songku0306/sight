import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NursingBaby extends StatefulWidget {
  @override
  _NursingBabyState createState() => _NursingBabyState();
}

class _NursingBabyState extends State<NursingBaby> {
  String serviceKey =
      'a3GptWb07Pi1Gxv7GDsZ195JQT%2BehIA65OSl04QTsSyaxeTIMA6Y7ZMOa9tIv7ywXzaqW5lWgpU4fjoRTT1lDA%3D%3D';

  Map<String, dynamic> babyData = {};

  @override
  void initState() {
    super.initState();
    fetchNursingData(); // 초기 데이터 로드
    Timer.periodic(
        Duration(minutes: 10), (Timer t) => fetchNursingData()); // 2시간마다 업데이트
  }

  Future<void> fetchNursingData() async {
    final Uri apiUrl = Uri.parse(
        'http://apis.data.go.kr/6260000/BusanNursingroomInfoService/getNursingroomInfo?serviceKey=$serviceKey&numOfRows=5&pageNo=1');

    final response = await http.get(apiUrl);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        babyData = data['sido']['confirm_date']['items']['item'];
      });
    } else {
      throw Exception('Failed to load nursing data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Nursing Room App'),
        ),
        body: Center(
          child: babyData.isNotEmpty
              ? NursingRoomList(babyData: babyData)
              : CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class NursingRoomList extends StatelessWidget {
  final Map<String, dynamic> babyData;

  NursingRoomList({required this.babyData});

  @override
  Widget build(BuildContext context) {
    final String sido = babyData['sido'] ?? '';
    final String confirmDate = babyData['confirm_date'] ?? '';
    final String address = babyData['address'] ?? '';
    final String sigungu = babyData['sigungu'] ?? '';
    final String tel = babyData['tel'] ?? '';
    final String target = babyData['target'] ?? '';
    final double lng = double.tryParse(babyData['lng'] ?? '') ?? 0.0;
    final String place = babyData['place'] ?? '';
    final double lat = double.tryParse(babyData['lat'] ?? '') ?? 0.0;
    final String sj = babyData['sj'] ?? '';
    final String father = babyData['father'] ?? '';

    return ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '시도: $sido',
                style: TextStyle(fontSize: 24),
              ),
              Text(
                '확인일: $confirmDate',
                style: TextStyle(fontSize: 24),
              ),
              Text(
                '주소: $address',
                style: TextStyle(fontSize: 24),
              ),
              Text(
                '시군구: $sigungu',
                style: TextStyle(fontSize: 24),
              ),
              Text(
                '전화번호: $tel',
                style: TextStyle(fontSize: 24),
              ),
              Text(
                '타겟: $target',
                style: TextStyle(fontSize: 24),
              ),
              Text(
                '경도: $lng',
                style: TextStyle(fontSize: 24),
              ),
              Text(
                '장소명: $place',
                style: TextStyle(fontSize: 24),
              ),
              Text(
                '위도: $lat',
                style: TextStyle(fontSize: 24),
              ),
              Text(
                '이름: $sj',
                style: TextStyle(fontSize: 24),
              ),
              Text(
                '아빠: $father',
                style: TextStyle(fontSize: 24),
              ),
            ],
          );
        });
  }
}
