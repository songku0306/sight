import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MemoScreen extends StatefulWidget {
  const MemoScreen({super.key});

  @override
  _MemoScreen createState() => _MemoScreen();
}

class _MemoScreen extends State<MemoScreen> {
  List<String> itemList = [];
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadItems();
  }

  Future<void> loadItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      itemList = prefs.getStringList('itemList') ?? [];
    });
  }

  Future<void> saveItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('itemList', itemList);
  }

  void addItem() {
    setState(() {
      itemList.add(textController.text);
      textController.clear();
      saveItems();
    });
  }

  void deleteItem(int index) {
    setState(() {
      itemList.removeAt(index);
      saveItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editable List'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: itemList.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(itemList[index]),
                  onDismissed: (direction) {
                    deleteItem(index);
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20.0),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: ListTile(
                    title: Text(itemList[index]),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: textController,
              decoration: InputDecoration(
                labelText: 'Enter your text',
                suffixIcon: IconButton(
                  onPressed: () => textController.clear(),
                  icon: const Icon(Icons.clear),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: addItem,
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
