import 'package:apioffline/units.dart';
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
        backgroundColor: Colors.white,
        title: const Row(
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
      body: const Center(
        child: Stack(
          children: [
            DiagonalBackgroundScreen(),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    NursingFrame(),
                    SizedBox(height: 10),
                    NursingFrame(),
                  ],
                ),
              ),
            ),
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
