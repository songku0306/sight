import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('chat'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, postion) {
                  return GestureDetector(
                    child: Card(child: Text('text list')),
                  );
                },
                itemCount: 5,
              ),
            ),
            Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.grey,
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: TextField(
                            style: TextStyle(color: Colors.black),
                            keyboardType: TextInputType.text,
                            decoration:
                                InputDecoration(hintText: "Send Message"),
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.all(0),
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.15,
                          height: MediaQuery.of(context).size.width * 0.1,
                          child: ElevatedButton(
                            onPressed:
                                () {}, // 여기 사용된 sendMessage 함수는 차후 websocket 연결에서 다룹니다.
                            child: Icon(Icons.send),
                          )),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
