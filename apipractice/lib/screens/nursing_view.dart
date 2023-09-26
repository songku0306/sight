import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart'; // geocoding 패키지 추가

class NursingRoomList extends StatelessWidget {
  final List<NursingRoomInfo> nursingRooms;
  final Position? currentPosition;

  NursingRoomList({required this.nursingRooms, required this.currentPosition});

  // 현재 위치를 주소로 변환하는 비동기 함수
  Future<String> getAddressFromCoordinates() async {
    if (currentPosition == null) {
      return '알 수 없음';
    }

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        currentPosition!.latitude,
        currentPosition!.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        return placemark.street.toString(); // xx동을 포함하는 주소
      }
    } catch (e) {
      print('Error getting address: $e');
    }

    return '알 수 없음';
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: nursingRooms.length,
      itemBuilder: (context, index) {
        final item = nursingRooms[index];
        return GestureDetector(
          onTap: () async {
            final message =
                '이름: ${item.sj}\n장소명: ${item.place}\n주소: ${item.address}\n아빠: ${item.father}';
            String currentAddress = await getAddressFromCoordinates();
            Fluttertoast.showToast(
              msg: '현재 위치: $currentAddress\n$message',
              toastLength: Toast.LENGTH_LONG,
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              child: ListTile(
                tileColor: Colors.indigo,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                title: Text(
                  '이름: ${item.sj}',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '장소명: ${item.place}',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '주소: ${item.address}',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '아빠: ${item.father}',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '확인일: ${item.confirmDate}',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// 나머지 코드는 동일하게 유지


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
