import 'package:flutter/material.dart';
import 'package:baybaby/view/detail_view.dart';

class BabyCareRecord {
  final String type;
  final String date;

  BabyCareRecord({
    required this.type,
    required this.date,
  });
}

class BabyCareScreen extends StatelessWidget {
  final List<BabyCareRecord> diaperRecords;
  final List<BabyCareRecord> feedingRecords;
  final List<BabyCareRecord> sleepRecords;
  final VoidCallback addDiaperRecord;
  final VoidCallback addFeedingRecord;
  final VoidCallback addSleepRecord;
  final void Function(String, int) deleteRecord;
  final void Function(List<BabyCareRecord>) navigateToDetailScreen;

  BabyCareScreen({
    required this.diaperRecords,
    required this.feedingRecords,
    required this.sleepRecords,
    required this.addDiaperRecord,
    required this.addFeedingRecord,
    required this.addSleepRecord,
    required this.deleteRecord,
    required this.navigateToDetailScreen,
  });

  Widget buildDataTable(List<BabyCareRecord> records, String title, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          width: 8,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DataTable(
        columns: const <DataColumn>[
          DataColumn(
            label: Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
        ],
        rows: records.map((record) {
          return DataRow(
            onLongPress: () => deleteRecord(record.type, records.indexOf(record)),
            color: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return color.withOpacity(0.6);
              }
              return color;
            }),
            cells: <DataCell>[
              DataCell(Text(record.date)),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget buildFloatingActionButton(String type, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: Size(80, 80),
        shape: CircleBorder(),
        padding: EdgeInsets.all(20),
        primary: color,
      ),
      child: Text(
        type,
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
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
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.all(5),
              primary: Colors.deepOrange,
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
              buildDataTable(diaperRecords, '기저귀', Colors.blue),
              const SizedBox(height: 30),
              buildDataTable(feedingRecords, '분유', Colors.green),
              const SizedBox(height: 30),
              buildDataTable(sleepRecords, '수면', Colors.red),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildFloatingActionButton('기저귀', Colors.blue, addDiaperRecord),
          const SizedBox(width: 10),
          buildFloatingActionButton('분유', Colors.green, addFeedingRecord),
          const SizedBox(width: 10),
          buildFloatingActionButton('수면', Colors.red, addSleepRecord),
        ],
      ),
    );
  }
}

void main() {
  final diaperRecords = <BabyCareRecord>[];
  final feedingRecords = <BabyCareRecord>[];
  final sleepRecords = <BabyCareRecord>[];

  runApp(
    DayTimeView(
      diaperRecords: diaperRecords,
      feedingRecords: feedingRecords,
      sleepRecords: sleepRecords,
    ),
  );
}
