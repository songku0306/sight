import 'package:baybaby/view/day_time.dart';
import 'package:flutter/material.dart';

class ButtonForMenu extends StatelessWidget {
  final String recordType; // 레코드 타입
  final List<BabyCareRecord> records; // 레코드 목록
  final TextEditingController controller; // 컨트롤러

  ButtonForMenu({
    required this.recordType,
    required this.records,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('새로운 레코드 추가'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: '레코드 내용을 입력하세요',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // 입력된 내용을 records에 추가하고 이전 페이지로 돌아갈 수 있는 코드
                Navigator.pop(context);
              },
              child: Text('추가'),
            ),
          ],
        ),
      ),
    );
  }
}
