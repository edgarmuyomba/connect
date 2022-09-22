import 'package:flutter/material.dart';


class proHome extends StatefulWidget {
  const proHome({super.key});

  @override
  State<proHome> createState() => _proHomeState();
}

class _proHomeState extends State<proHome> {
  var _currentPage = 0;

  var _pages = [
    Text('Page 1 - Profile'),
    Text('Page 2 - Reviews'),
    Text('Page 3 - Chats'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: _pages.elementAt(_currentPage)),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.reviews),
              label: 'Reviews',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Chats',
            ),
          ],
          currentIndex: _currentPage,
          fixedColor: Colors.blue,
          onTap: (int inIndex) {
            setState(() {
              _currentPage = inIndex;
            });
          },
        ),
      );
  }
}