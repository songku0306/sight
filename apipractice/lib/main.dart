import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(NursingRoomApp());
}

class NursingRoomApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nursing Room App',
      home: NursingRoomScreen(),
    );
  }
}

class NursingRoomScreen extends StatefulWidget {
  @override
  _NursingRoomScreenState createState() => _NursingRoomScreenState();
}

class _NursingRoomScreenState extends State<NursingRoomScreen> {
  String serviceKey = 'a3GptWb07Pi1Gxv7GDsZ195JQT%2BehIA65OSl04QTsSyaxeTIMA6Y7ZMOa9tIv7ywXzaqW5lWgpU4fjoRTT1lDA%3D%3D';
  String apiUrl =
      'http://apis.data.go.kr/6260000/BusanNursingroomInfoService/getNursingroomInfo?serviceKey=$serviceKey&numOfRows=10&pageNo=1';

  bool isLoading = false;
  List<NursingRoomInfo> nursingRooms = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<dynamic> items =
            jsonData['getNursingroomInfo']['body']['items']['item'];

        nursingRooms = items.map((item) {
          return NursingRoomInfo(
            sido: item['sido'],
            sigungu: item['sigungu'],
            sj: item['sj'],
            address: item['address'],
            place: item['place'],
            tel: item['tel'],
            target: item['target'],
            father: item['father'],
            lng: double.parse(item['lng']),
            lat: double.parse(item['lat']),
            confirmDate: item['confirm_date'],
          );
        }).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nursing Room'),
      ),
      body: Center(
        child:
            isLoading ? CircularProgressIndicator() : NursingRoomList(nursingRooms),
      ),
    );
  }
}

class NursingRoomInfo {
  final String? sido;
  final String? sigungu;
  final String? sj;
  final String? address;
  final String? place;
  final String? tel;
  final String? target;
  final String? father;
  final double lng;
  final double lat;
  final String? confirmDate;

  NursingRoomInfo({
    this.sido,
    this.sigungu,
    this.sj,
    this.address,
    this.place,
    this.tel,
    this.target,
    this.father,
    required this.lng,
    required this.lat,
    this.confirmDate,
});

class NursingRoomList extends StatelessWidget {
final List<NursingRoomInfo> nursingRooms;

NursingRoomList({required this.nursingRooms});

@override
Widget build(BuildContext context) {
return ListView.builder(
itemCount: nursingRooms.length,
itemBuilder:(context, index){
final room = nursingRooms[index];
return ListTile(
title : Text(room.sj ?? ''),
subtitle : Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text('Address: ${room.address ?? ''}'),
Text('Tel: ${room.tel ?? ''}'),
Text('Place: ${room.place ?? ''}'),
Text('Sido: ${room.sido ?? ''}'),
Text('Sigungu: ${room.sigungu ?? ''}'),
Text('Target: ${room.target ?? ''}'),
Text('Father: ${room.father ?? ''}'),
Text('Confirm Date:${room.confirmDate??''}')
],
),
);
},
);
}
}
