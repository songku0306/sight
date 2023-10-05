import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(NursingRoomApp());
}

class NursingRoomApp extends StatelessWidget {
  const NursingRoomApp({Key? key});

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
  Position? currentPosition;
  List<NursingRoomInfo> nursingRooms = [];
  String serviceKey =
      'a3GptWb07Pi1Gxv7GDsZ195JQT%2BehIA65OSl04QTsSyaxeTIMA6Y7ZMOa9tIv7ywXzaqW5lWgpU4fjoRTT1lDA%3D%3D';

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchNursingRoomData();
  }

  Future<void> _fetchNursingRoomData() async {
    try {
      setState(() {
        isLoading = true;
      });

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final apiUrl = Uri.parse(
        'http://apis.data.go.kr/6260000/BusanNursingroomInfoService/getNursingroomInfo?serviceKey=$serviceKey&numOfRows=15&pageNo=1',
      );

      final response = await http.get(apiUrl);

     
if (response.statusCode == 200) {
  final jsonData = jsonDecode(response.body);
  final itemList = jsonData['response']['body']['items']['item'];

  if (itemList is List) {
    final List<NursingRoomInfo> data =
        itemList.map((item) => parseItem(item)).toList();

    // Sort nursingRooms by distance (if currentPosition is available)
    if (currentPosition != null) {
      data.sort((a, b) {
        double distanceA = Geolocator.distanceBetween(
          currentPosition!.latitude,
          currentPosition!.longitude,
          a.lat,
          a.lng,
        );

        double distanceB = Geolocator.distanceBetween(
          currentPosition!.latitude,
          currentPosition!.longitude,
          b.lat,
          b.lng,
        );

        return distanceA.compareTo(distanceB);
      });
    }

    setState(() {
      nursingRooms = data; // nursingRooms에 데이터 저장
      isLoading = false; // 데이터 로딩 완료
    });
  } else {
    throw Exception('Unexpected data structure');
  }
} else {
  throw Exception('Failed to load nursing room data');
}




      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('오류 발생'),
            content: Text('데이터를 불러오는 중 오류가 발생했습니다. 다시 시도해주세요.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('확인'),
              ),
            ],
          );
        },
      );

      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '부산 수유실',
              style: TextStyle(color: Colors.black),
            ),
            if (currentPosition != null) // 현재 위치가 있을 때만 표시
              Text(
                '현재 위치: ${currentPosition!.latitude}, ${currentPosition!.longitude}',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
          ],
        ),
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : nursingRooms.isNotEmpty
                ? NursingRoomList(nursingRooms: nursingRooms)
                : Text('데이터가 없습니다.'),
      ),
    );
  }
}

class NursingRoomList extends StatelessWidget {
  final List<NursingRoomInfo> nursingRooms;

  NursingRoomList({required this.nursingRooms});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: nursingRooms.length,
      separatorBuilder: (BuildContext context, int index) => Divider(),
      itemBuilder: (context, index) {
        final item = nursingRooms[index];
        return ListTile(
          title: Text('이름: ${item.sj}'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text('장소명: ${item.place}'),
              Text('주소: ${item.address}'),
              Text('아빠: ${item.father}'),
              Text('확인일: ${item.confirmDate}'),
            ],
          ),
        );
      },
    );
  }
}

class NursingRoomInfo {
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

  NursingRoomInfo({
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
}
