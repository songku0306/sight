import 'package:flutter/material.dart';

class BabyCareRecord {
  final String type;
  final String date;

  BabyCareRecord({
    required this.type,
    required this.date,
  });
}

class BabyCareScreen extends StatefulWidget {
  @override
  _BabyCareScreenState createState() => _BabyCareScreenState();
}

class _BabyCareScreenState extends State<BabyCareScreen> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<BabyCareRecord> records = [];
  int selectedIndex = -1;

  void addRecord(String type) {
    final now = DateTime.now();
    final record = BabyCareRecord(
      type: type,
      date: '${now.year}-${now.month}-${now.day} ${now.hour}:${now.minute}',
    );

    setState(() {
      records.insert(0, record);
      _listKey.currentState?.insertItem(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('데일리기록'),
      ),
      body: AnimatedList(
        key: _listKey,
        initialItemCount: records.length,
        itemBuilder: (context, index, animation) {
          final record = records[index];

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return RecordDetailPage(record: record);
                  },
                ),
              );
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              decoration: BoxDecoration(
                color: selectedIndex == index ? Colors.blue : Colors.transparent,
                border: Border.all(color: Colors.blue),
              ),
              padding: EdgeInsets.all(16.0),
              child: Text(
                record.type,
                style: TextStyle(
                  fontSize: 20,
                  color: selectedIndex == index ? Colors.white : Colors.black,
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => addRecord('Sleep'),
            style: ElevatedButton.styleFrom(
              fixedSize: Size(80, 80),
              shape: CircleBorder(),
              padding: EdgeInsets.all(20),
              primary: Colors.blue,
            ),
            child: const Text(
              '수면',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(width: 10),
          ElevatedButton(
            onPressed: () => addRecord('Feeding'),
            style: ElevatedButton.styleFrom(
              fixedSize: Size(80, 80),
              shape: CircleBorder(),
              padding: EdgeInsets.all(20),
              primary: Colors.green,
            ),
            child: const Text(
              '분유',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(width: 10),
          ElevatedButton(
            onPressed: () => addRecord('Diaper'),
            style: ElevatedButton.styleFrom(
              fixedSize: Size(80, 80),
              shape: CircleBorder(),
              padding: EdgeInsets.all(20),
              primary: Colors.red,
            ),
            child: const Text(
              '기저귀',
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

class RecordDetailPage extends StatelessWidget {
  final BabyCareRecord record;

  RecordDetailPage({required this.record});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(record.type),
      ),
      body: Center(
        child: Hero(
          tag: 'record_${record.type}',
          child: Container(
            color: Colors.blue, // 테이블과 같은 색상
            padding: EdgeInsets.all(16.0),
            child: Text(
              record.type,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
