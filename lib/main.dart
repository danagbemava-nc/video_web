import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Test',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: "Noto Sans JP"),
      home: TestHome(),
    );
  }
}

class TestHome extends StatefulWidget {
  TestHome({Key? key}) : super(key: key);

  @override
  _TestHomeState createState() => _TestHomeState();
}

class _TestHomeState extends State<TestHome> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      this._selectedIndex = index;
    });
  }

  Widget _getFooter() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: _selectedIndex == 0 ? Colors.black87 : Colors.black26,
          ),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.account_circle,
            color: _selectedIndex == 1 ? Colors.black87 : Colors.black26,
          ),
          label: "account",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.add,
            color: _selectedIndex == 2 ? Colors.black87 : Colors.black26,
          ),
          label: "add",
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.black45,
      unselectedItemColor: Colors.black26,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          return Future.value(false);
        },
        child: Scaffold(
          body: Container(
            color: Colors.blue,
          ),
          bottomNavigationBar: _getFooter(),
        ));
  }
}
