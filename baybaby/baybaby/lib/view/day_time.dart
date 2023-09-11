import 'package:baybaby/view/detail_view.dart';
import 'package:flutter/material.dart';

class BabyCareRecord {
  final String type;
  final String date;

  BabyCareRecord({
    required this.type,
    required this.date,
  });
}

class DayTimeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Baby Care App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BabyCareScreen(),
    );
  }
}

class BabyCareScreen extends StatefulWidget {
  @override
  _BabyCareScreenState createState() => _BabyCareScreenState();
}

class _BabyCareScreenState extends State<BabyCareScreen> {
  final TextEditingController sleepTimeController = TextEditingController();
  final TextEditingController feedingTimeController = TextEditingController();
  final TextEditingController diaperTimeController = TextEditingController();
  List<BabyCareRecord> sleepRecords = [];
  List<BabyCareRecord> feedingRecords = [];
  List<BabyCareRecord> diaperRecords = [];
  List<Widget> sleepRecordsButton = [];
  List<Widget> feedingRecordsButton = [];
  List<Widget> diaperRecordsButton = [];

  void addRecord(String type) {
    final now = DateTime.now();
    final record = BabyCareRecord(
      type: type,
      date: '${now.year}-${now.month}-${now.day} ${now.hour}:${now.minute}',
    );

    setState(() {
      if (type == 'Diaper') {
        diaperRecords.insert(0, record);
        // 스위치 동작 시 '수면' ElevatedButton 추가
        sleepRecordsButton.add(
          ElevatedButton(
            onPressed: () => navigateToDetailScreen(diaperRecords),
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
            ),
            child: Text(
              '기저귀',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        );
      } else if (type == 'Feeding') {
        feedingRecords.insert(0, record);
        // 스위치 동작 시 '분유' ElevatedButton 추가
        feedingRecordsButton.add(
          ElevatedButton(
            onPressed: () => navigateToDetailScreen(feedingRecords),
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
            ),
            child: Text(
              '분유',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        );
      } else if (type == 'Sleep') {
        sleepRecords.insert(0, record);
        // 스위치 동작 시 '기저귀' ElevatedButton 추가
        diaperRecordsButton.add(
          ElevatedButton(
            onPressed: () => navigateToDetailScreen(sleepRecords),
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
            ),
            child: Text(
              '수면',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        );
      }
    });
  }

  void navigateToDetailScreen(List<BabyCareRecord> records) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailView(records: records),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white38,
        title: const Text('데일리기록'),
        actions: [
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              fixedSize: Size(80, 80),
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(10.0), // 모서리 둥근 정도 설정
              ),

              padding: EdgeInsets.all(5), // 버튼 주위의 여백 설정
              primary: Colors.deepOrange, // 배경색을 변경하려면 primary 속성을 사용합니다.
            ),
            child: const Text(
              '마감',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // 설정 버튼을 눌렀을 때 수행할 동작을 정의합니다.
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  border: Border.all(
                    width: 8,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DataTable(
                  columns: const <DataColumn>[
                    DataColumn(
                        label: Text('기저귀',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ))),
                  ],
                  rows: sleepRecords.map((record) {
                    return DataRow(
                      color: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                        // 특정 상태에 따라 행의 색상을 설정합니다.
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.blueAccent; // 선택된 경우
                        }
                        return Colors
                            .lightBlue; // 기본 색상 (null로 설정하면 테마의 색상을 사용합니다)
                      }),
                      cells: <DataCell>[
                        DataCell(Text(record.date)),
                      ],
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 30), // 30픽셀의 공간 추가
              Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  border: Border.all(
                    width: 8,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DataTable(
                  columns: const <DataColumn>[
                    DataColumn(
                        label: Text('분유',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ))),
                  ],
                  rows: feedingRecords.map((record) {
                    return DataRow(
                      color: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                        // 특정 상태에 따라 행의 색상을 설정합니다.
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.green; // 선택된 경우
                        }
                        return Colors
                            .lightGreen; // 기본 색상 (null로 설정하면 테마의 색상을 사용합니다)
                      }),
                      cells: <DataCell>[
                        DataCell(Text(record.date)),
                      ],
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 30), // 30픽셀의 공간 추가
              Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  border: Border.all(
                    width: 8,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DataTable(
                  columns: const <DataColumn>[
                    DataColumn(
                        label: Text('수면',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ))),
                  ],
                  rows: diaperRecords.map((record) {
                    return DataRow(
                      color: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                        // 특정 상태에 따라 행의 색상을 설정합니다.
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.redAccent; // 선택된 경우
                        }
                        return Colors
                            .redAccent; // 기본 색상 (null로 설정하면 테마의 색상을 사용합니다)
                      }),
                      cells: <DataCell>[
                        DataCell(Text(record.date)),
                      ],
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => addRecord('Sleep'),
            style: ElevatedButton.styleFrom(
              fixedSize: Size(80, 80),
              shape: CircleBorder(), // 동그라미 모양의 버튼
              padding: EdgeInsets.all(20), // 버튼 주위의 여백 설정
              primary: Colors.blue, // 배경색을 변경하려면 primary 속성을 사용합니다.
            ),
            child: const Text(
              '기저귀',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () => addRecord('Feeding'),
            style: ElevatedButton.styleFrom(
              fixedSize: Size(80, 80),
              shape: CircleBorder(), // 동그라미 모양의 버튼
              padding: EdgeInsets.all(20), // 버튼 주위의 여백 설정
              primary: Colors.green, // 배경색을 변경하려면 primary 속성을 사용합니다.
            ),
            child: const Text(
              '분유',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () => addRecord('Diaper'),
            style: ElevatedButton.styleFrom(
              fixedSize: Size(80, 80),
              shape: CircleBorder(),
              padding: EdgeInsets.all(20), // 버튼 주위의 여백 설정
              primary: Colors.red, // 배경색을 변경하려면 primary 속성을 사용합니다.
            ),
            child: const Text(
              '수면',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
