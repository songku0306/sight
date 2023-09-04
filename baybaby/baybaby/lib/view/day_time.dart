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

  void addRecord(String type) {
    final now = DateTime.now();
    final record = BabyCareRecord(
      type: type,
      date: '${now.year}-${now.month}-${now.day} ${now.hour}:${now.minute}',
    );

    setState(() {
      if (type == 'Sleep') {
        sleepRecords.add(record);
      } else if (type == 'Feeding') {
        feedingRecords.add(record);
      } else if (type == 'Diaper') {
        diaperRecords.add(record);
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
        title: const Text('Baby Care App'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                '수면',
                style: TextStyle(fontSize: 20, color: Colors.blue),
              ),
            ),
            DataTable(
              columns: const <DataColumn>[
                DataColumn(
                    label: Text('수면', style: TextStyle(color: Colors.blue))),
              ],
              rows: sleepRecords.map((record) {
                return DataRow(
                  cells: <DataCell>[
                    DataCell(Text(record.date)),
                  ],
                );
              }).toList(),
            ),
            const SizedBox(height: 30), // 30픽셀의 공간 추가
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                '분유',
                style: TextStyle(fontSize: 20, color: Colors.green),
              ),
            ),
            DataTable(
              columns: const <DataColumn>[
                DataColumn(
                    label: Text('분유', style: TextStyle(color: Colors.green))),
              ],
              rows: feedingRecords.map((record) {
                return DataRow(
                  cells: <DataCell>[
                    DataCell(Text(record.date)),
                  ],
                );
              }).toList(),
            ),
            const SizedBox(height: 30), // 30픽셀의 공간 추가
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                '기저귀',
                style: TextStyle(fontSize: 20, color: Colors.red),
              ),
            ),
            DataTable(
              columns: const <DataColumn>[
                DataColumn(
                    label: Text('기저귀', style: TextStyle(color: Colors.red))),
              ],
              rows: diaperRecords.map((record) {
                return DataRow(
                  cells: <DataCell>[
                    DataCell(Text(record.date)),
                  ],
                );
              }).toList(),
            ),

            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => addRecord('Sleep'),
                  child: const Text('수면 기록 추가',
                      style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => addRecord('Feeding'),
                  child: const Text('분유 기록 추가',
                      style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => addRecord('Diaper'),
                  child: const Text('기저귀 기록 추가',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => navigateToDetailScreen(sleepRecords),
              child:
                  const Text('수면 기록 보기', style: TextStyle(color: Colors.white)),
            ),
            // 나머지 기록 보기 버튼도 동일하게 구성
          ],
        ),
      ),
    );
  }
}
