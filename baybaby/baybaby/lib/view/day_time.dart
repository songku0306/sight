import 'package:baybaby/view/detail_view.dart';
import 'package:baybaby/view/temporary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // provider 패키지를 import 합니다.

class BabyCareRecord {
  final String type;
  final String date;
  final TextEditingController? textfieldController; // TextEditingController 추가
  final double? feedingAmount; // 수유량 (ml)
  final Duration? sleepTime; // 수면 시간 (시간:분)
  final int? diaperCount; // 기저귀 횟수

  BabyCareRecord({
    required this.type,
    required this.date,
    this.textfieldController, // TextEditingController로 변경
    this.feedingAmount,
    this.sleepTime,
    this.diaperCount,
  });
}

class DayTimeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Baby Care App',
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
  final TextEditingController feedingAmountController =
      TextEditingController(); // 추가

  List<BabyCareRecord> sleepRecords = [];
  List<BabyCareRecord> feedingRecords = [];
  List<BabyCareRecord> diaperRecords = [];
  List<Widget> sleepRecordsButton = [];
  List<Widget> feedingRecordsButton = [];
  List<Widget> diaperRecordsButton = [];

  void addRecord(String type,
      {double? feedingAmount, Duration? sleepTime, int? diaperCount}) {
    final now = DateTime.now();
    int hour = now.hour;
    String amPm = 'AM';

    if (hour >= 12) {
      amPm = 'PM';
      if (hour > 12) {
        hour -= 12;
      }
    }
    final record = BabyCareRecord(
      type: type,
      date: ' ${now.second}  ${now.month}/${now.day} $hour:${now.minute} $amPm',
      feedingAmount: feedingAmount,
      sleepTime: sleepTime,
      diaperCount: diaperCount,
    );

    setState(() {
      if (type == 'Diaper') {
        diaperRecords.insert(0, record);
        diaperRecordsButton.add(
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
      } else if (type == 'Sleep') {
        sleepRecords.insert(0, record);
        sleepRecordsButton.add(
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

  void addRecordFromButton(String type) {
    final now = DateTime.now();
    int hour = now.hour;
    String amPm = 'AM';
    if (hour >= 12) {
      amPm = 'PM';
      if (hour > 12) {
        hour -= 12;
      }
    }

    final ml = feedingAmountController.text;
    final record = BabyCareRecord(
      type: type,
      date: ml + ' ml  ' + '${now.month}/${now.day} $hour:${now.minute} $amPm',
      textfieldController: TextEditingController(text: ml),
    );

    setState(() {
      if (type == 'Feeding') {
        feedingRecords.insert(0, record);
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
      } else {
        feedingRecords.insert(0, record);
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
      }
    });
  }

  void deleteRecord(String type, int index) {
    setState(() {
      if (type == 'Diaper' && index >= 0 && index < diaperRecords.length) {
        diaperRecords.removeAt(index); // 레코드 목록에서 해당 인덱스의 항목 삭제
        diaperRecordsButton.removeAt(index); // 버튼 목록에서 해당 인덱스의 항목 삭제
      } else if (type == 'Feeding' &&
          index >= 0 &&
          index < feedingRecords.length) {
        feedingRecords.removeAt(index);
        feedingRecordsButton.removeAt(index);
      } else if (type == 'Sleep' && index >= 0 && index < sleepRecords.length) {
        sleepRecords.removeAt(index);
        sleepRecordsButton.removeAt(index);
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

  double calculateTotalFeedingAmount() {
    double totalAmount = 0.0;
    for (var record in feedingRecords) {
      if (record.feedingAmount != null) {
        totalAmount += record.feedingAmount!;
      }
    }
    return totalAmount;
  }

  Duration calculateTotalSleepTime() {
    Duration totalSleep = Duration.zero;
    for (var record in sleepRecords) {
      if (record.sleepTime != null) {
        totalSleep += record.sleepTime!;
      }
    }
    return totalSleep;
  }

  int calculateTotalDiaperCount() {
    int totalDiaperCount = 0;
    for (var record in diaperRecords) {
      if (record.diaperCount != null) {
        totalDiaperCount += record.diaperCount!;
      }
    }
    return totalDiaperCount;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          DailyReportProvider(), // DailyReportProvider를 생성하고 제공합니다.

      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white38,
          title: const Text('데일리기록'),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MemoApp(),
                  )),
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
            SizedBox(
              width: 40,
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // 데일리 리포트
                // Provider로부터 데이터를 사용하여 데일리 리포트를 표시합니다.
                Consumer<DailyReportProvider>(
                  builder: (context, dailyReportProvider, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '데일리 리포트',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                            '총 수유량: ${dailyReportProvider.totalFeedingAmount} ml'),
                        Text(
                          '총 수면 시간: ${dailyReportProvider.totalSleepHours}시간 ${dailyReportProvider.totalSleepMinutes}분',
                        ),
                        Text(
                            '총 기저귀 횟수: ${dailyReportProvider.totalDiaperCount}회'),
                      ],
                    );
                  },
                ),

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
                    rows: diaperRecords.map((record) {
                      return DataRow(
                        onLongPress: () => deleteRecord(
                            'Diaper',
                            diaperRecords.indexOf(
                                record)), // 'Diaper' 타입과 해당 레코드의 인덱스 전달
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
                            )),
                      ),
                    ],
                    rows: feedingRecords.map((record) {
                      return DataRow(
                        onLongPress: () => deleteRecord(
                            'Feeding',
                            feedingRecords.indexOf(
                                record)), // 'Diaper' 타입과 해당 레코드의 인덱스 전달),
                        color: MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                          // 특정 상태에 따라 행의 색상을 설정합니다.
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.greenAccent; // 선택된 경우
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
                    rows: sleepRecords.map((record) {
                      return DataRow(
                        onLongPress: () => deleteRecord(
                            'Sleep',
                            sleepRecords.indexOf(
                                record)), // 'Diaper' 타입과 해당 레코드의 인덱스 전달),
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
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 150,
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                color: Colors.lightGreen,
                border: Border.all(
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: TextField(
                controller: feedingAmountController, // 컨트롤러 할당
                decoration: InputDecoration(hintText: '분유양을 입력해주세요!'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => addRecord('Diaper'),
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
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    addRecordFromButton('Feeding');
                    addRecord('Feeding');
                  },
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
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => addRecord('Sleep'),
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
          ],
        ),
      ),
    );
  }
}

// DailyReportProvider 클래스 정의
class DailyReportProvider with ChangeNotifier {
  double _totalFeedingAmount = 0.0;
  Duration _totalSleepTime = Duration.zero;
  int _totalDiaperCount = 0;

  // Getter 메서드를 사용하여 데이터를 노출합니다.
  double get totalFeedingAmount => _totalFeedingAmount;
  int get totalSleepHours => _totalSleepTime.inHours;
  int get totalSleepMinutes => _totalSleepTime.inMinutes % 60;
  int get totalDiaperCount => _totalDiaperCount;

  // 데이터를 업데이트하는 메서드를 정의합니다.
  void updateFeedingAmount(double amount) {
    _totalFeedingAmount += amount;
    notifyListeners(); // 상태 변경을 알립니다.
  }

  void updateSleepTime(Duration time) {
    _totalSleepTime += time;
    notifyListeners();
  }

  void updateDiaperCount(int count) {
    _totalDiaperCount += count;
    notifyListeners();
  }
}
