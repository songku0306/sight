import 'package:flutter/material.dart';


class BabyCareRecord {
  final String type;
  final String date;

  BabyCareRecord({
    required this.type,
    required this.date,
  });
}

class WeekTimeView extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Baby Care App'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
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
            SizedBox(height: 30), // 30픽셀의 공간 추가
            Padding(
              padding: const EdgeInsets.all(16.0),
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
            SizedBox(height: 30), // 30픽셀의 공간 추가
            Padding(
              padding: const EdgeInsets.all(16.0),
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
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => addRecord('Sleep'),
            child: Text('수면', style: TextStyle(color: Colors.white)),
          ),
          SizedBox(width: 10),
          ElevatedButton(
            onPressed: () => addRecord('Feeding'),
            child: Text('분유', style: TextStyle(color: Colors.white)),
          ),
          SizedBox(width: 10),
          ElevatedButton(
            onPressed: () => addRecord('Diaper'),
            child: Text('기저귀', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
