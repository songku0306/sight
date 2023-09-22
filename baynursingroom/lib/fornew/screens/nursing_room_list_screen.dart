import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/nursing_room_provider.dart';

class NursingRoomListScreen extends StatefulWidget {
  @override
  _NursingRoomListScreenState createState() => _NursingRoomListScreenState();
}

class _NursingRoomListScreenState extends State<NursingRoomListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<NursingRoomProvider>(context, listen: false)
        .fetchNursingRooms();
  }

  @override
  Widget build(BuildContext context) {
    final nursingRooms = Provider.of<NursingRoomProvider>(context).nursingRooms;

    return Scaffold(
      appBar: AppBar(
        title: Text('Nursing Room List'),
      ),
      body: ListView.builder(
        itemCount: nursingRooms.length,
        itemBuilder: (ctx, index) {
          final room = nursingRooms[index];
          return ListTile(
            title: Text(room.sj),
            subtitle: Text(room.address),
            trailing: Text(room.tel),
            onTap: () {
              // 주소 복사 기능 추가
              // Clipboard.setData(ClipboardData(text: room.address));
            },
          );
        },
      ),
    );
  }
}
