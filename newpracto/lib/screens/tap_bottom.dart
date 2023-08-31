import 'package:flutter/material.dart';
import 'package:newpracto/screens/bank_screen.dart';
import 'package:newpracto/screens/count_saved.dart';
import 'package:newpracto/screens/layout_screen.dart';
import 'package:newpracto/screens/todo.dart';

class TapBottom extends StatefulWidget {
  const TapBottom({super.key});

  @override
  State<TapBottom> createState() => _TapBottomState();
}

class _TapBottomState extends State<TapBottom> {
  int _selectedIndex = 0;
  final List<Widget> _children = <Widget>[
    BankScreen(),
    CountSaved(),
    LayoutScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _children.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, size: 40, color: Colors.black),
            activeIcon: Icon(Icons.favorite, size: 40, color: Colors.orange),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, size: 40, color: Colors.black),
            activeIcon: Icon(Icons.search, size: 40, color: Colors.orange),
            label: 'search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, size: 40, color: Colors.black),
            activeIcon: Icon(Icons.settings_accessibility,
                size: 40, color: Colors.orange),
            label: 'setting',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: _onItemTapped,
      ),
    );
  }
}
