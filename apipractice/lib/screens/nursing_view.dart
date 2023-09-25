import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NursingRoomList extends StatelessWidget {
  final List<NursingRoomInfo> nursingRooms;

  NursingRoomList({required this.nursingRooms});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: nursingRooms.length,
      itemBuilder: (context, index) {
        final item = nursingRooms[index];
        return GestureDetector(
          onTap: () {
            final message =
                '이름: ${item.sj}\n장소명: ${item.place}\n주소: ${item.address}\n아빠: ${item.father}';
            Fluttertoast.showToast(
              msg: message,
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
                  borderRadius: BorderRadius.circular(25), // 이 부분에서 둥근 모서리 설정
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
