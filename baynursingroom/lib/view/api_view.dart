import 'package:baynursingroom/data/api_data.dart';
import 'package:baynursingroom/view/nursing_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:xml2json/xml2json.dart';
import 'dart:core';

class NursingRoomAppli extends StatelessWidget {
  const NursingRoomAppli({Key? key});

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
    fetchNursingroomInfo(); // fetchNursingroomInfo 함수를 호출하도록 추가
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

      // '외부인'을 타겟으로 가진 데이터만 필터링하여 반환
      final filteredData = data.where((room) => room.target == '외부인').toList();

      return filteredData;
    } else {
      throw Exception('Failed to load nursing room data');
    }
  }

  Future<void> fetchData() async {
    try {
      setState(() {
        isLoading = true; // 데이터 로딩 시작
      });

      final data = await fetchNursingRoomData();
      setState(() {
        nursingRooms = data;
        isLoading = false; // 데이터 로딩 완료
      });
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
                  Navigator.of(context).pop(); // 경고창 닫기
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

  void fetchNursingroomInfo() async {
    final response = await http.get(
      Uri.parse(
          'http://apis.data.go.kr/6260000/BusanNursingroomInfoService/getNursingroomInfo?serviceKey=$serviceKey&numOfRows=5&pageNo=1'),
    );

    if (response.statusCode == 200) {
      Xml2Json xml2Json = Xml2Json();
      xml2Json.parse(response.body);
      var jsonData = xml2Json.toParker();

      // 이제 jsonData는 JSON 형식이므로, 필요한 정보를 추출하여 UI에 표시할 수 있습니다.

      print(jsonData);
    } else {
      throw Exception('Failed to load data');
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
                ? NursingRoomList()
                : Text('데이터가 없습니다.'), // 데이터가 없는 경우에 메시지 출력
      ),
    );
  }
}

class NursingRoomList extends StatelessWidget {
  final List<Map<String, dynamic>>? nursingRooms; // null 가능한 리스트로 변경

  NursingRoomList({this.nursingRooms}); // required 제거

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: nursingRooms?.length ?? 0, // null 체크 추가
      itemBuilder: (context, index) {
        final item = nursingRooms?[index]; // null 체크 추가
        if (item == null) {
          return SizedBox(); // null일 경우 빈 위젯 반환
        }
        return ListTile(
          title: Text('이름: ${item['sj']}'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('주소: ${item['address']}'),
              Text('전화번호: ${item['tel']}'),
              Text('장소명: ${item['place']}'),
              Text('시도: ${item['sido']}'),
              Text('시군구: ${item['sigungu']}'),
              Text('타겟: ${item['target']}'),
              Text('아빠: ${item['father']}'),
              Text('확인일: ${item['confirmDate']}'),
              Text('위도: ${item['lng']}'),
              Text('경도: ${item['lat']}'),
            ],
          ),
        );
      },
    );
  }
}
