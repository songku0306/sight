import 'package:flutter/material.dart';

class NursingCard extends StatelessWidget {
  final Map<String, dynamic> data;

  NursingCard({required this.data});

  @override
  Widget build(BuildContext context) {
    final String sj = data['sj'] ?? 'N/A';
    final String address = data['address'] ?? 'N/A';
    final String tel = data['tel'] ?? 'N/A';
    final String father = data['father'] ?? 'N/A';
    final String place = data['place'] ?? 'N/A';
    final String confirmDate = data['confirm_date'] ?? 'N/A';

    return Scaffold(
      appBar: AppBar(
        title: Text('Nursing Room Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('기관명: $sj', style: TextStyle(fontSize: 20)),
            Text('주소: $address', style: TextStyle(fontSize: 20)),
            Text('전화번호: $tel', style: TextStyle(fontSize: 20)),
            Text('아빠 이용 가능: $father', style: TextStyle(fontSize: 20)),
            Text('위치: $place', style: TextStyle(fontSize: 20)),
            Text('데이터 기준일자: $confirmDate', style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
