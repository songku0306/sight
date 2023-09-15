import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

void main() {
  runApp(MemoApp());
}

class MemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memo App',
      theme: ThemeData(
        primaryColor: Colors.red,
        fontFamily: 'Roboto',
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: Colors.orange),
      ),
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
  List<MemoItem> _memos = [];
  Color _selectedColor = Colors.blue; // 선택된 색상

  @override
  void initState() {
    super.initState();
    _loadMemos();
  }

  void _loadMemos() async {
    final prefs = await SharedPreferences.getInstance();
    final memoList = prefs.getStringList('memos') ?? [];
    setState(() {
      _memos = memoList
          .map((memo) =>
              MemoItem(text: memo, isChecked: false, color: Colors.blue))
          .toList();
    });
  }

  void _saveMemos() async {
    final prefs = await SharedPreferences.getInstance();
    final memoList = _memos.map((memo) => memo.text).toList();
    prefs.setStringList('memos', memoList);
  }

  void _addMemo(String memo) {
    if (memo.isNotEmpty) {
      setState(() {
        _memos
            .add(MemoItem(text: memo, isChecked: false, color: _selectedColor));
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

  void _showColorPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('color'),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: _selectedColor,
              onColorChanged: (color) {
                setState(() {
                  _selectedColor = color;
                });
              },
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '메모장 앱',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _memos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    children: [
                      Checkbox(
                        value: _memos[index].isChecked,
                        onChanged: (value) {
                          setState(() {
                            _memos[index].isChecked = value ?? false;
                            _saveMemos();
                          });
                        },
                      ),
                      Text(
                        _memos[index].text,
                        style: TextStyle(color: _memos[index].color),
                      ),
                    ],
                  ),
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
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    _showColorPicker(context);
                  },
                  child: Text('색상 선택'),
                ),
                Expanded(
                  child: TextField(
                    controller: _memoController,
                    decoration: InputDecoration(
                      labelText: '새 메모 추가',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.save),
                  onPressed: () {
                    _addMemo(_memoController.text);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MemoItem {
  final String text;
  bool isChecked;
  final Color color;

  MemoItem({
    required this.text,
    required this.isChecked,
    required this.color,
  });
}
