import 'package:dwm14/components/drawer.dart';
import 'package:dwm14/components/landing.dart';
import 'package:dwm14/screens/detail.dart';
import 'package:flutter/material.dart';

import '../components/square.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedPage = 0;
  int nb = 0;
  Color color = Colors.blue;
  bool disable = false;

  _onTap(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  List<Widget> list = [
    Landing(),
    Container(
      color: Colors.grey,
      child: Column(
        children: [
          Text('Random',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 42)),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Builder(
                  builder: (context) => GestureDetector(
                    child: Square(number: 1),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailScreen()));
                    },
                  ),
                ),
                SizedBox(width: 10),
                Builder(
                  builder: (context) => GestureDetector(
                    child: Square(number: 2),
                    onTap: () {
                      Navigator.pushNamed(context, '/profile');
                    },
                  ),
                ),
                SizedBox(width: 10),
                Builder(
                  builder: (context) => GestureDetector(
                    child: Square(number: 3),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/important');
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    Text('Important')
  ];

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter'),
        ),
        drawerEnableOpenDragGesture: !disable,
        drawer: DrawerMenu(),
        body: SafeArea(
          child: list[_selectedPage],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Movies',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.fingerprint),
              label: 'Random Function',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.lightbulb),
              label: 'Presentation',
            ),
          ],
          currentIndex: _selectedPage,
          selectedItemColor: Colors.lightBlue[800],
          onTap: (index) {
            _onTap(index);
          },
        ));
  }
}

class RowCube extends StatelessWidget {
  const RowCube({
    Key key,
    this.firstCubeColor,
    this.secondCubeColor,
  }) : super(key: key);

  final firstCubeColor;
  final secondCubeColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Square(
          color: firstCubeColor,
        ),
        SizedBox(
          width: 10,
        ),
        Square(color: secondCubeColor),
      ],
    );
  }
}
