import 'package:baybaby/view/day_time.dart';
import 'package:flutter/material.dart';

class DetailView extends StatelessWidget {
  final List<BabyCareRecord> records;

  DetailView({required this.records});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('기록 상세 보기'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '기록 목록',
                style: TextStyle(fontSize: 20, color: Colors.blue),
              ),
            ),
            DataTable(
              columns: const <DataColumn>[
                DataColumn(label: Text('날짜', style: TextStyle(color: Colors.blue))),
              ],
              rows: records.map((record) {
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
    );
  }
}