import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(MyApp());
}

class SleepRecord {
  final int id;
  final String date;
  final int sleepTime;
  final int feedingTime;
  final int diaperTime;

  SleepRecord({
    required this.id,
    required this.date,
    required this.sleepTime,
    required this.feedingTime,
    required this.diaperTime,
  });
}

class MyApp extends StatelessWidget {
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
  late Database database;
  final TextEditingController sleepTimeController = TextEditingController();
  final TextEditingController feedingTimeController = TextEditingController();
  final TextEditingController diaperTimeController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<SleepRecord> records = [];

  @override
  void initState() {
    super.initState();
    initializeDatabase();
  }

  Future<void> initializeDatabase() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'baby_care.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE sleep_records(id INTEGER PRIMARY KEY AUTOINCREMENT, date TEXT, sleep_time INTEGER, feeding_time INTEGER, diaper_time INTEGER)',
        );
      },
      version: 1,
    );

    fetchDataFromDatabase();
  }

  Future<void> fetchDataFromDatabase() async {
    final List<Map<String, dynamic>> maps = await database.query('sleep_records');
    records = List.generate(maps.length, (i) {
      return SleepRecord(
        id: maps[i]['id'],
        date: maps[i]['date'],
        sleepTime: maps[i]['sleep_time'],
        feedingTime: maps[i]['feeding_time'],
        diaperTime: maps[i]['diaper_time'],
      );
    });
    setState(() {});
  }

  Future<void> insertDataToDatabase(SleepRecord record) async {
    await database.insert(
      'sleep_records',
      record.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  void dispose() {
    sleepTimeController.dispose();
    feedingTimeController.dispose();
    diaperTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Baby Care App'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: sleepTimeController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: '수면 시간 (분)'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '수면 시간을 입력하세요';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: feedingTimeController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: '분유 시간 (분)'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '분유 시간을 입력하세요';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: diaperTimeController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: '기저귀 시간 (분)'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '기저귀 시간을 입력하세요';
                        }
                        return null;
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        final sleepTime = int.parse(sleepTimeController.text);
                        final feedingTime = int.parse(feedingTimeController.text);
                        final diaperTime = int.parse(diaperTimeController.text);

                        final record = SleepRecord(
                          id: null,
                          date: DateTime.now().toString(),
                          sleepTime: sleepTime,
                          feedingTime: feedingTime,
                          diaperTime: diaperTime,
                        );

                        insertDataToDatabase(record);
                        fetchDataFromDatabase();

                        sleepTimeController.clear();
                        feedingTimeController.clear();
                        diaperTimeController.clear();
                      }
                    },
                    child: Text('저장'),
                  ),
                ],
              ),
            ),
            DataTable(
              columns: const <DataColumn>[
                DataColumn(label: Text('날짜')),
                DataColumn(label: Text('수면 시간 (분)')),
                DataColumn(label: Text('분유 시간 (분)')),
                DataColumn(label: Text('기저귀 시간 (분)')),
              ],
              rows: records.map((record) {
                return DataRow(
                  cells: <DataCell>[
                    DataCell(Text(record.date)),
                    DataCell(Text(record.sleepTime.toString())),
                    DataCell(Text(record.feedingTime.toString())),
                    DataCell(Text(record.diaperTime.toString())),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}