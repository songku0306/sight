import 'package:flutter/material.dart';

class Menu {
  final String name;
  final String sub;
  bool isEnabled;

  Menu({
    required this.name,
    required this.sub,
    required this.isEnabled,
  });
}

class MenuList extends StatefulWidget {
  final List<Menu> menus = [
    Menu(
      name: '수면',
      sub: 'Sub 1',
      isEnabled: true,
    ),
    Menu(
      name: '분유',
      sub: 'Sub 2',
      isEnabled: true,
    ),
    Menu(
      name: '기저귀',
      sub: 'Sub 3',
      isEnabled: true,
    ),
    Menu(
      name: '목욕',
      sub: 'Sub 4',
      isEnabled: false,
    ),
  ];

  MenuList({Key? key}) : super(key: key);

  @override
  State<MenuList> createState() => _MenuListState();
}

class _MenuListState extends State<MenuList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 80,
              backgroundColor: Colors.amber,
            ),
            SizedBox(width: 16),
            Column(
              children: [
                Text(
                  '홍길동',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '2023/06/13',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          '선택사항',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          itemCount: widget.menus.length,
          itemBuilder: (context, index) {
            final menu = widget.menus[index];

            return ListTile(
              enabled: menu.isEnabled,
              leading: const Icon(Icons.person),
              title: Text(menu.name),
              subtitle: Text('1'),
              trailing: Switch(
                onChanged: (bool? value) {
                  setState(() {
                    menu.isEnabled = value!;
                  });
                },
                value: menu.isEnabled,
              ),
            );
          },
        ),
      ],
    );
  }
}
