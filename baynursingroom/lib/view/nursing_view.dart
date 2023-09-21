import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:xml2json/xml2json.dart';

class NursingRoomScreen extends StatefulWidget {
  @override
  _NursingRoomScreenState createState() => _NursingRoomScreenState();
}

class _NursingRoomScreenState extends State<NursingRoomScreen> {
  List<NursingRoomInfo> nursingRooms = [];
  String serviceKey =
      'a3GptWb07Pi1Gxv7GDsZ195JQT%2BehIA65OSl04QTsSyaxeTIMA6Y7ZMOa9tIv7ywXzaqW5lWgpU4fjoRTT1lDA%3D%3D';

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      setState(() {
        isLoading = true;
      });

      final data = await fetchNursingRoomData();
      setState(() {
        nursingRooms = data;
        isLoading = false;
      });
    } catch (e) {
      showErrorDialog('데이터를 불러오는 중 오류가 발생했습니다. 다시 시도해주세요.');
      print('Error: $e');
    }
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('오류 발생'),
          content: Text(message),
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
  }

  Future<List<NursingRoomInfo>> fetchNursingRoomData() async {
    final apiUrl = Uri.parse(
        'http://apis.data.go.kr/6260000/BusanNursingroomInfoService/getNursingroomInfo?serviceKey=$serviceKey&numOfRows=5&pageNo=1');

    final queryParams = {
      'serviceKey': serviceKey,
      'numOfRows': '10',
      'pageNo': '1',
      'sj': '영도도서관',
      'resultType': 'json',
    };

    final client = http.Client();
    final response = await client.get(apiUrl);

    if (response.statusCode == 200) {
      final document = xml.XmlDocument.parse(response.body);
      final items = document.findAllElements('item');

      final List<NursingRoomInfo> data = items.map((element) {
        return NursingRoomInfo.fromJson({
          'tel': element.findElements('tel').single.text,
          'sj': element.findElements('sj').single.text,
          'address': element.findElements('address').single.text,
          'place': element.findElements('place').single.text,
          'sido': element.findElements('sido').single.text,
          'sigungu': element.findElements('sigungu').single.text,
          'target': element.findElements('target').single.text,
          'father': element.findElements('father').single.text,
          'lng': double.parse(element.findElements('lng').single.text),
          'lat': double.parse(element.findElements('lat').single.text),
          'confirm_date': element.findElements('confirm_date').single.text,
        });
      }).toList();

      client.close();
      return data;
    } else {
      throw Exception('Failed to load nursing room data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'), // 영어 (미국)
        const Locale('ko', 'KR'), // 한국어 (대한민국)
        // 지원하는 다른 로캘을 여기에 추가하세요.
      ],
      title: '부산 수유실',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            '부산 수유실',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : nursingRooms.isNotEmpty
                  ? NursingRoomList(nursingRooms: nursingRooms)
                  : Text('데이터가 없습니다.'),
        ),
      ),
    );
  }
}

class NursingRoomList extends StatelessWidget {
  final List<NursingRoomInfo> nursingRooms;

  NursingRoomList({required this.nursingRooms});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: nursingRooms.length,
      itemBuilder: (context, index) {
        final item = nursingRooms[index];
        return Card(
          margin: EdgeInsets.all(8.0),
          child: ListTile(
            title: Text('이름: ${item.sj}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('주소: ${item.address}'),
                Text('전화번호: ${item.tel}'),
                Text('장소명: ${item.place}'),
                Text('시도: ${item.sido}'),
                Text('시군구: ${item.sigungu}'),
                Text('타겟: ${item.target}'),
                Text('아빠: ${item.father}'),
                Text('확인일: ${item.confirmDate}'),
                Text('위도: ${item.lat}'),
                Text('경도: ${item.lng}'),
              ],
            ),
          ),
        );
      },
    );
  }
}

class NursingRoomInfo {
  final String tel;
  final String sj;
  final String address;
  final String place;
  final String sido;
  final String sigungu;
  final String target;
  final String father;
  final double lng;
  final double lat;
  final String confirmDate;

  NursingRoomInfo({
    required this.tel,
    required this.sj,
    required this.address,
    required this.place,
    required this.sido,
    required this.sigungu,
    required this.target,
    required this.father,
    required this.lng,
    required this.lat,
    required this.confirmDate,
  });

  factory NursingRoomInfo.fromJson(Map<String, dynamic> json) {
    return NursingRoomInfo(
      tel: json['tel'],
      sj: json['sj'],
      address: json['address'],
      place: json['place'],
      sido: json['sido'],
      sigungu: json['sigungu'],
      target: json['target'],
      father: json['father'],
      lng: double.parse(json['lng']),
      lat: double.parse(json['lat']),
      confirmDate: json['confirm_date'],
    );
  }
}
