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
    Menu(
      name: '투약',
      sub: 'Sub 5',
      isEnabled: false,
    ),
    Menu(
      name: '병원',
      sub: 'Sub 6',
      isEnabled: false,
    ),
    Menu(
      name: '온도',
      sub: 'Sub 7',
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Row(
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
            const SizedBox(height: 8),
            const Text(
              '선택사항',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.menus.length,
              itemBuilder: (context, index) {
                final menu = widget.menus[index];

                return ListTile(
                  enabled: menu.isEnabled,
                  leading: const Icon(Icons.person),
                  title: Text(menu.name),
                  subtitle: Text(menu.sub),
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
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => addRecord('Sleep'),
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(80, 80),
              shape: const CircleBorder(), // 동그라미 모양의 버튼
              padding: const EdgeInsets.all(20), // 버튼 주위의 여백 설정
              primary: Colors.blue, // 배경색을 변경하려면 primary 속성을 사용합니다.
            ),
            child: const Text(
              '수면',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () => addRecord('Feeding'),
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(80, 80),
              shape: const CircleBorder(), // 동그라미 모양의 버튼
              padding: const EdgeInsets.all(20), // 버튼 주위의 여백 설정
              primary: Colors.green, // 배경색을 변경하려면 primary 속성을 사용합니다.
            ),
            child: const Text(
              '분유',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () => addRecord('Diaper'),
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(80, 80),
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(20), // 버튼 주위의 여백 설정
              primary: Colors.red, // 배경색을 변경하려면 primary 속성을 사용합니다.
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

addRecord(String s) {}
