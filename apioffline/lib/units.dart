import 'package:flutter/material.dart';


class NursingFrame extends StatelessWidget {
  const NursingFrame({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('장소명', style: TextStyle(fontSize: 30)),
                Text('확인일:2020/12/30'),
              ],
            ),
            Row(
              children: [
                Text('주소 : ', style: TextStyle(fontSize: 20)),
                Text('주소 / '),
                Text('위치'),
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
