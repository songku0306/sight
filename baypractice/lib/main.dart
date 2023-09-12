import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MemoApp());
}

class MemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memo App',
      home: MemoScreen(),
    );
  }
}

class MemoScreen extends StatefulWidget {
  @override
  _MemoScreenState createState() => _MemoScreenState();
}

class _MemoScreenState extends State<MemoScreen> {
  final TextEditingController _memoController = TextEditingController();
  List<String> _memos = [];

  @override
  void initState() {
    super.initState();
    _loadMemos();
  }

  void _loadMemos() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _memos = prefs.getStringList('memos') ?? [];
    });
  }

  void _saveMemos() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('memos', _memos);
  }

  void _addMemo(String memo) {
    if (memo.isNotEmpty) {
      setState(() {
        _memos.add(memo);
        _saveMemos();
        _memoController.clear();
      });
    }
  }

  void _deleteMemo(int index) {
    setState(() {
      _memos.removeAt(index);
      _saveMemos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('메모장 앱'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _memos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_memos[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteMemo(index);
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _memoController,
              decoration: InputDecoration(
                labelText: '새 메모 추가',
                suffixIcon: IconButton(
                  icon: Icon(Icons.save),
                  onPressed: () {
                    _addMemo(_memoController.text);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
