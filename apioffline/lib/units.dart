import 'package:flutter/material.dart';

class NursingFrame extends StatelessWidget {
  const NursingFrame({
    super.key,
  });

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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '사하구건강가정지원센터공동육아나눔터',
                    style: TextStyle(fontSize: 30),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text('확인일:2020/12/30'),
              ],
            ),
            Row(
              children: [
                Text('주소 : ', style: TextStyle(fontSize: 20)),
                Expanded(
                    child: Text(
                        '부산 해운대구 해운대로 지하 396 (우동, 부산지하철 시립미술관역)' + '고객센터 옆')),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('아빠가능 : 가능'),
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
          colors: [Colors.blue, Colors.blueGrey],
        ),
      ),
    );
  }
}
