import 'package:baybaby/view/day_time.dart';
import 'package:baybaby/view/profile.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentPageIndex = 0;
  }

  /*
   * bottomNavigation UI 
   */

  Widget _bottomNavigationWidget() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentPageIndex,
      onTap: (index) {
        setState(() {
          _currentPageIndex = index;
        });
      },
      selectedItemColor: Colors.black,
      items: <BottomNavigationBarItem>[
        _bottomNavigationBarItem("home", "홈"),
        _bottomNavigationBarItem("notes", "동네생활"),
        _bottomNavigationBarItem("location", "내 근처"),
        _bottomNavigationBarItem("chat", "채팅"),
        _bottomNavigationBarItem("user", "나의 당근"),
      ],
    );
  }

  BottomNavigationBarItem _bottomNavigationBarItem(
      String iconName, String name) {
    IconData iconData;
    switch (iconName) {
      case "home":
        iconData = Icons.home;
        break;
      case "notes":
        iconData = Icons.notes;
        break;
      case "location":
        iconData = Icons.location_city;
        break;
      case "chat":
        iconData = Icons.chat;
        break;
      case "user":
        iconData = Icons.person;
        break;
      default:
        iconData = Icons.home;
    }

    return BottomNavigationBarItem(
      icon: Icon(iconData),
      label: name,
    );
  }

  /*
   * body UI 
   */
  Widget _bodyWidget() {
    switch (_currentPageIndex) {
      case 0:
        return DayTimeView();
        break;
      case 1:
        return Container();
        break;
      case 2:
        return Container();
        break;
      case 3:
        return Container();
        break;
      case 4:
        return ProfileView();
        break;
    }
    return Container();
  }

  /*
   * Home 위젯 구성 
   */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyWidget(),
      bottomNavigationBar: _bottomNavigationWidget(),
    );
  }
}
