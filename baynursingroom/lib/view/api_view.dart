// import 'package:baynursingroom/data/api_data.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:xml/xml.dart' as xml;
// import 'package:xml2json/xml2json.dart';

// class NursingRoomApp extends StatelessWidget {
//   const NursingRoomApp({Key? key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Nursing Room App',
//       home: NursingRoomScreen(),
//     );
//   }
// }

// class NursingRoomScreen extends StatefulWidget {
//   @override
//   _NursingRoomScreenState createState() => _NursingRoomScreenState();
// }

// class _NursingRoomScreenState extends State<NursingRoomScreen> {
//   List<NursingRoomInfo> nursingRooms = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchData(); // initState에서 데이터 로드
//   }

//   Future<void> fetchData() async {
//     try {
//       final data = await fetchNursingRoomData();
//       setState(() {
//         nursingRooms = data;
//       });
//     } catch (e) {
//       // 오류 처리
//       print('Error: $e');
//     }
//   }

//   void fetchNursingroomInfo() async {
//     final response = await http.get(
//       Uri.parse(
//           'http://apis.data.go.kr/6260000/BusanNursingroomInfoService/getNursingroomInfo?serviceKey=인증키&numOfRows=5&pageNo=1'),
//     );

//     if (response.statusCode == 200) {
//       Xml2Json xml2Json = Xml2Json();
//       xml2Json.parse(response.body);
//       var jsonData = xml2Json.toParker();

//       // 이제 jsonData는 JSON 형식이므로, 필요한 정보를 추출하여 UI에 표시할 수 있습니다.

//       print(jsonData);
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }
//   // Future<List<NursingRoomInfo>> fetchNursingRoomData() async {
//   //   final apiKey =
//   //       'a3GptWb07Pi1Gxv7GDsZ195JQT%2BehIA65OSl04QTsSyaxeTIMA6Y7ZMOa9tIv7ywXzaqW5lWgpU4fjoRTT1lDA%3D%3D';
//   //   final apiUrl = Uri.parse(
//   //       'http://apis.data.go.kr/6260000/BusanNursingroomInfoService/getNursingroomInfo');

//   //   final queryParams = {
//   //     'serviceKey': apiKey,
//   //     'numOfRows': '10',
//   //     'pageNo': '1',
//   //     'sj': '영도도서관',
//   //     'resultType': 'xml',
//   //   };

//   //   final response =
//   //       await http.get(apiUrl.replace(queryParameters: queryParams));

//   //   if (response.statusCode == 200) {
//   //     final document = xml.XmlDocument.parse(response.body);
//   //     final items = document.findAllElements('item');

//   //     final List<NursingRoomInfo> data = items.map((element) {
//   //       return NursingRoomInfo(
//   //         tel: element.findElements('tel').single.text,
//   //         sj: element.findElements('sj').single.text,
//   //         address: element.findElements('address').single.text,
//   //         place: element.findElements('place').single.text,
//   //         sido: element.findElements('sido').single.text,
//   //         sigungu: element.findElements('sigungu').single.text,
//   //         target: element.findElements('target').single.text,
//   //         father: element.findElements('father').single.text,
//   //         lng: double.parse(element.findElements('lng').single.text),
//   //         lat: double.parse(element.findElements('lat').single.text),
//   //         confirmDate: element.findElements('confirm_date').single.text,
//   //       );
//   //     }).toList();

//   //     return data;
//   //   } else {
//   //     throw Exception('Failed to load nursing room data');
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: Text(
//           '부산 수유실',
//           style: TextStyle(
//             color: Colors.black,
//           ),
//         ),
//       ),
//       body: Center(
//         child: nursingRooms.isNotEmpty
//             ? NursingRoomList(nursingRooms: nursingRooms)
//             : CircularProgressIndicator(),
//       ),
//     );
//   }
// }

// class NursingRoomList extends StatelessWidget {
//   final List<NursingRoomInfo> nursingRooms;

//   NursingRoomList({required this.nursingRooms});

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: nursingRooms.length,
//       itemBuilder: (context, index) {
//         final item = nursingRooms[index];
//         return ListTile(
//           title: Text('이름: ${item.sj}'),
//           subtitle: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('주소: ${item.address}'),
//               Text('전화번호: ${item.tel}'),
//               // Text('이름: ${item.sj}'),
//             Text('장소명: ${item.place}'),
//             Text('시도: ${item.sido}'),
//             Text('시군구: ${item.sigungu}'),
//             Text('타겟: ${item.target}'),
//             Text('아빠: ${item.father}'),
//             Text('확인일: ${item.confirmDate}'),
//             Text('위도: ${item.lng}'),
//             Text('경도: ${item.lat}'),
//               // 필요한 다른 데이터도 표시
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
