import 'package:baynursingroom/fornew/models/nursing_room.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NursingRoomProvider with ChangeNotifier {
  List<NursingRoom> _nursingRooms = [];

  List<NursingRoom> get nursingRooms => _nursingRooms;

  Future<void> fetchNursingRooms() async {
    final apiKey =
        'a3GptWb07Pi1Gxv7GDsZ195JQT+ehIA65OSl04QTsSyaxeTIMA6Y7ZMOa9tIv7ywXzaqW5lWgpU4fjoRTT1lDA=='; // 여기에 서비스 키를 입력하세요
    final apiUrl =
        'http://apis.data.go.kr/6260000/BusanNursingroomInfoService'; // API 엔드포인트 URL

    try {
      final response = await http.get(
        Uri.parse('$apiUrl?apiKey=$apiKey'),
      );

      if (response.statusCode == 200) {
        // JSON 데이터를 파싱하여 List<NursingRoom> 형태로 저장
        final List<dynamic> parsedData = json.decode(response.body);
        _nursingRooms =
            parsedData.map((data) => NursingRoom.fromJson(data)).toList();
        notifyListeners();
      } else {
        // API 요청이 실패한 경우
        print('Error fetching nursing rooms: ${response.statusCode}');
      }
    } catch (error) {
      // 에러 처리
      print('Error fetching nursing rooms: $error');
    }
  }
}
