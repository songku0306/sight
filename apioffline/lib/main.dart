import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart'; // Geocoding import

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<List<dynamic>> csvData = [];
  Position? myLocation; // late 제거하고 nullable 타입으로 변경
  String currentPlace = ""; // 사용자의 현재 위치(주소)

  Future<void> loadCSV() async {
    final String csvString =
        await rootBundle.loadString('assets/data.csv'); // CSV 파일 경로
    final List<List<dynamic>> csvTable =
        CsvToListConverter().convert(csvString);
    setState(() {
      csvData = csvTable;
    });
  }

  Future<void> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // 권한이 거부된 경우 처리
      return;
    }

    Position position = await Geolocator.getCurrentPosition();

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    setState(() {
      myLocation = position;
      currentPlace = placemarks[0].subLocality ?? ""; // 동 이름 설정하기

      if (currentPlace.isEmpty) {
        currentPlace = "위치 정보 없음";
      }
    });
  }

  double calculateDistance(double lon1, double lat1, double lon2, double lat2) {
    double distanceInMeters =
        Geolocator.distanceBetween(lat1, lon1, lat2, lon2);

    return distanceInMeters / 1000; //km 단위 반환
  }

  @override
  Widget build(BuildContext context) {
    // csvData를 내 위치와 가까운 순서대로 정렬
    // csvData 정렬 부분에서 null check 추가
    if (myLocation != null) {
      csvData.sort((a, b) {
        double aLongitude = double.parse(a[8]); // 경도 열 인덱스
        double aLatitude = double.parse(a[9]); // 위도 열 인덱스
        double bLongitude = double.parse(b[8]); // 경도 열 인덱스
        double bLatitude = double.parse(b[9]); // 위도 열 인덱스

        double distanceA = calculateDistance(
            aLongitude, aLatitude, myLocation!.longitude, myLocation!.latitude);
        double distanceB = calculateDistance(
            bLongitude, bLatitude, myLocation!.longitude, myLocation!.latitude);

        return distanceA.compareTo(distanceB);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('내 위치와 가까운 데이터 표시 ($currentPlace)'),
      ),
      body: ListView.builder(
        itemCount: csvData.length,
        itemBuilder: (context, index) {
          final row = csvData[index];
          return ListTile(
            title: Text(row[0]), // 기관명 열 인덱스
            subtitle: Text(
                '주소: ${row[1]}, 위치: ${row[2]}, 대상: ${row[3]}, 아빠이용: ${row[4]}, 데이터 기준일자: ${row[5]}'),
          );
        },
      ),
    );
  }
}
