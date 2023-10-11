import 'package:apioffline/nursingview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

String place_name = '사하구건강가정지원센터공동육아나눔터';
String confirm_date = '확인일:2020/12/30';
String adress_one = '부산 해운대구 해운대로 지하 396 (우동, 부산지하철 시립미술관역)';
String adress_two = '고객센터 옆';
String father = '가능';

class NursingFrame extends StatelessWidget {
  const NursingFrame({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15), //모서리를 둥글게
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    place_name,
                    style: TextStyle(fontSize: 30),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(confirm_date),
              ],
            ),
            Row(
              children: [
                Text('주소 : ', style: TextStyle(fontSize: 20)),
                Expanded(child: Text(adress_one + adress_two)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('아빠가능 : $father'),
                Text('주소 복사 '),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DiagonalBackgroundScreen extends StatelessWidget {
  const DiagonalBackgroundScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
          colors: [Colors.blue, Colors.indigo],
        ),
      ),
    );
  }
}