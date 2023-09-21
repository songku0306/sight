import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NursingRoom {
  final String sido;
  final String sigungu;
  final String sj;
  final String address;
  final String place;
  final String tel;
  final String target;
  final String father;
  final double lng;
  final double lat;
  final String confirmDate;

  NursingRoom({
    required this.sido,
    required this.sigungu,
    required this.sj,
    required this.address,
    required this.place,
    required this.tel,
    required this.target,
    required this.father,
    required this.lng,
    required this.lat,
    required this.confirmDate,
  });

  factory NursingRoom.fromJson(Map<String, dynamic> json) {
    return NursingRoom(
      sido: json['sido'],
      sigungu: json['sigungu'],
      sj: json['sj'],
      address: json['address'],
      place: json['place'],
      tel: json['tel'],
      target: json['target'],
      father: json['father'],
      lng: double.parse(json['lng']),
      lat: double.parse(json['lat']),
      confirmDate: json['confirm_date'],
    );
  }
}

class MyApp extends StatelessWidget {
  String serviceKey =
      'a3GptWb07Pi1Gxv7GDsZ195JQT%2BehIA65OSl04QTsSyaxeTIMA6Y7ZMOa9tIv7ywXzaqW5lWgpU4fjoRTT1lDA%3D%3D';

  Future<List<NursingRoom>> fetchNursingRooms() async {
    final response = await http.get(
      Uri.parse(
          'http://apis.data.go.kr/6260000/BusanNursingroomInfoService/getNursingroomInfo?$serviceKey=인증키&numOfRows=5&pageNo=1'),
      headers: {'Accept': 'application/json'},
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> items = data['body']['items'];

      return items.map((item) => NursingRoom.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load nursing rooms');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('수유실 보유 시설 현황'),
        ),
        body: FutureBuilder<List<NursingRoom>>(
          future: fetchNursingRooms(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('데이터가 없습니다.'));
            } else {
              final nursingRooms = snapshot.data!;
              return ListView.builder(
                itemCount: nursingRooms.length,
                itemBuilder: (context, index) {
                  final room = nursingRooms[index];
                  return ListTile(
                    title: Text('기관명: ${room.sj}'),
                    subtitle: Text('주소: ${room.address}'),
                    // 필요한 다른 정보들을 여기에 추가할 수 있습니다.
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
