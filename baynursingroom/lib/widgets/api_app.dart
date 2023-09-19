import 'package:baynursingroom/data/api_data.dart';
import 'package:flutter/material.dart';

class NursingRoomList extends StatelessWidget {
  final List<NursingRoomInfo> nursingRooms;

  NursingRoomList({required this.nursingRooms});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: nursingRooms.length,
      itemBuilder: (context, index) {
        final item = nursingRooms[index];
        return Card(
          margin: EdgeInsets.all(8.0),
          child: ListTile(
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
                Text('위도: ${item.lat}'),
                Text('경도: ${item.lng}'),
              ],
            ),
          ),
        );
      },
    );
  }
}
