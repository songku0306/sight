import 'package:apipractice/screens/nursing_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:xml2json/xml2json.dart';
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

  bool isLoading = false; // 데이터 로딩 상태 플래그 추가

  @override
  void initState() {
    super.initState();
    updateLocation(); // 앱 시작 시 현재 위치 정보 업데이트
    fetchData(); // 데이터 가져오기
  }

  Future<void> _calculateDistance() async {
    try {
      if (currentPosition == null) {
        currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
      }

      nursingRooms.sort((a, b) {
        // NursingRoom의 위도와 경도를 사용하여 거리 계산
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

        // 거리를 기준으로 오름차순으로 정렬
        return distanceA.compareTo(distanceB);
      });
    } catch (e) {
      print('Error calculating distance: $e');
    }
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
        isLoading = true;
      });

      await _calculateDistance(); // 거리 계산 함수 호출

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
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
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
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            if (currentPosition != null) // 현재 위치가 있을 때만 표시
              Text(
                '현재 위치: ${currentPosition!.latitude}, ${currentPosition!.longitude}',
                style: TextStyle(
                  fontSize: 12, // 텍스트 크기 조정
                  color: Colors.grey, // 텍스트 색상 설정
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
                : Text('데이터가 없습니다.'), // 데이터가 없는 경우에 메시지 출력
      ),
    );
  }
}
