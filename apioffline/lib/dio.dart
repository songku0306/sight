import 'package:apioffline/main.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();
  final String serviceKey =
      'a3GptWb07Pi1Gxv7GDsZ195JQT%2BehIA65OSl04QTsSyaxeTIMA6Y7ZMOa9tIv7ywXzaqW5lWgpU4fjoRTT1lDA%3D%3D';

  Future<List<NursingRoomInfo>> fetchNursingRoomData() async {
    try {
      final response = await _dio.get(
        'http://apis.data.go.kr/6260000/BusanNursingroomInfoService/getNursingroomInfo',
        queryParameters: {
          'serviceKey': serviceKey,
          'numOfRows': '10',
          'pageNo': '1',
          'sj': '영도도서관',
          'resultType': 'json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = response.data;

        // NursingRoomInfo 객체로 변환하는 함수를 정의합니다.
        NursingRoomInfo parseItem(Map<String, dynamic> item) {
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
        }

        // itemList 내의 모든 아이템을 NursingRoomInfo 객체로 변환합니다.
        final itemList = jsonData['response']['body']['items']['item'];

        if (itemList is List) {
          final List<NursingRoomInfo> data =
              itemList.map((item) => parseItem(item)).toList();
          return data;
        } else {
          throw Exception('Unexpected data structure');
        }
      } else {
        throw Exception('Failed to load nursing room data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
