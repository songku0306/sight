import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:xml2json/xml2json.dart';
import 'dart:convert';

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
  List<NursingRoomInfo> nursingRooms = [];
  String serviceKey =
      'a3GptWb07Pi1Gxv7GDsZ195JQT%2BehIA65OSl04QTsSyaxeTIMA6Y7ZMOa9tIv7ywXzaqW5lWgpU4fjoRTT1lDA%3D%3D';

  bool isLoading = false; // 데이터 로딩 상태 플래그 추가

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<List<NursingRoomInfo>> fetchNursingRoomData() async {
    final apiUrl = Uri.parse(
        'http://apis.data.go.kr/6260000/BusanNursingroomInfoService/getNursingroomInfo?serviceKey=$serviceKey&numOfRows=5&pageNo=1');

    final queryParams = {
      'serviceKey': serviceKey,
      'numOfRows': '10',
      'pageNo': '1',
      'sj': '영도도서관',
      'resultType': 'json', // XML 형식으로 요청
    };

    final response =
        await http.get(apiUrl.replace(queryParameters: queryParams));

    if (response.statusCode == 200) {
      final document = xml.XmlDocument.parse(response.body);
      final items = document.findAllElements('item');

      final List<NursingRoomInfo> data = items.map((element) {
        return NursingRoomInfo(
          tel: element.findElements('tel').single.text,
          sj: element.findElements('sj').single.text,
          address: element.findElements('address').single.text,
          place: element.findElements('place').single.text,
          sido: element.findElements('sido').single.text,
          sigungu: element.findElements('sigungu').single.text,
          target: element.findElements('target').single.text,
          father: element.findElements('father').single.text,
          lng: double.parse(element.findElements('lng').single.text),
          lat: double.parse(element.findElements('lat').single.text),
          confirmDate: element.findElements('confirm_date').single.text,
        );
      }).toList();

      setState(() {
        nursingRooms = data; // nursingRooms에 파싱한 데이터 저장
      });

      return data;
    } else {
      throw Exception('Failed to load nursing room data');
    }
  }

// ...

  Future<void> fetchData() async {
    try {
      setState(() {
        isLoading = true; // 데이터 로딩 시작
      });

      final response = await http.get(
        Uri.parse(
            'http://apis.data.go.kr/6260000/BusanNursingroomInfoService/getNursingroomInfo?serviceKey=$serviceKey&numOfRows=5&pageNo=1'),
      );

      if (response.statusCode == 200) {
        String responseBody = response.body;

        if (responseBody.contains('<')) {
          print('The response contains "<" character.');

          // XML to JSON 변환
          final xmlConverter = Xml2Json();
          xmlConverter.parse(responseBody);
          responseBody = xmlConverter.toParker();

          print('Converted JSON: $responseBody');

          // Further processing...
        }

        final jsonData = jsonDecode(responseBody);

        // NursingRoomInfo 객체로 변환하는 함수를 정의합니다.
        NursingRoomInfo parseItem(Map<String, dynamic> item) {
          return NursingRoomInfo(
            sido: item["sido"],
            sigungu: item["sigungu"],
            sj: item["sj"],
            address: item["address"],
            place: item["place"],
            tel: item["tel"],
            target: item["target"],
            father: item["father"],
            lng: double.parse(item["lng"]),
            lat: double.parse(item["lat"]),
            confirmDate: item["confirm_date"],
          );
        }

        // itemList 내의 모든 아이템을 NursingRoomInfo 객체로 변환합니다.
        final itemList = jsonData['response']['body']['items']['item'];

        if (itemList is List) {
          final List<NursingRoomInfo> data =
              itemList.map((item) => parseItem(item)).toList();

          setState(() {
            nursingRooms = data; // nursingRooms에 데이터 저장
            isLoading = false; // 데이터 로딩 완료
          });
        } else {
          throw Exception('Unexpected data structure');
        }
      }
    } catch (e) {
      setState(() {
        isLoading = false; // 데이터 로딩 실패
      });

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

      print('Error:$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                : Text('데이터가 없습니다.'), // 데이터가 없는 경우에 메시지 출력
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
        return ListTile(
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
              Text('위도: ${item.lng}'),
              Text('경도: ${item.lat}'),
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
