import 'package:flutter/material.dart';

class NursingRoomApp extends StatelessWidget {
  const NursingRoomApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nursing Room App',
      home: NursingRoomScreen(),
    );
  }
}

class NursingRoomScreen extends StatefulWidget {
  @override
  _NursingRoomScreenState createState() => _NursingRoomScreenState();
}

class _NursingRoomScreenState extends State<NursingRoomScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '부산 수유실',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            // if (currentPosition != null) // 현재 위치가 있을 때만 표시
            //   Text(
            //     '현재 위치: {currentPosition!.latitude}, {currentPosition!.longitude}',
            //     style: TextStyle(
            //       fontSize: 12, // 텍스트 크기 조정
            //       color: Colors.grey, // 텍스트 색상 설정
            //     ),
            //   ),
          ],
        ),
      ),
      body: Center(
        child: Stack(
          children: [
            DiagonalBackgroundScreen(),
            Center(
              child: Container(
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
                        children: [
                          Text('아빠가능 : 가능'),
                          Text('주소 / '),
                          Text('위치'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      // isLoading
      //     ? CircularProgressIndicator()
      //     : nursingRooms.isNotEmpty
      //         ? NursingRoomList(
      //             nursingRooms: nursingRooms,
      //             currentPosition: currentPosition,
      //           )
      //         : Text('데이터가 없습니다.'), // 데이터가 없는 경우에 메시지 출력
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
