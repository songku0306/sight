import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(NpractApp());
}

class NpractApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nursing Room App',
      home: NursingScreen(),
    );
  }
}

class NursingScreen extends StatefulWidget {
  @override
  _NursingScreenState createState() => _NursingScreenState();
}

class _NursingScreenState extends State<NursingScreen> {
  String address = "로딩 중...";

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position currentLocation =
          await Geolocator.getCurrentPosition(); // getCurrentPosition 사용
      String currentAddress = await getAddressFromLocation(currentLocation);
      setState(() {
        address = currentAddress;
      });
    } catch (e) {
      setState(() {
        address = "위치 정보를 가져오는 데 실패했습니다.";
      });
    }
  }

  Future<String> getAddressFromLocation(Position position) async {
    // 주소 변환 로직 구현 필요
    // 위치 정보(position)을 주소로 변환하는 로직 작성 (geocoding 패키지 활용)
    // 예시 코드:
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    Placemark placeMark = placemarks.first;
    String address =
        '${placeMark.country}, ${placeMark.administrativeArea}, ${placeMark.locality}, ${placeMark.thoroughfare}';

    return address;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('place : $address'),
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
