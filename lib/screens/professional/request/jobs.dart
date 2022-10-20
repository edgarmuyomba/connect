import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/professional/request/accepted.dart';
import 'package:flutter_application_1/screens/professional/request/complete.dart';
import 'package:flutter_application_1/screens/professional/request/status.dart';

class job extends StatefulWidget {
  const job({super.key});

  @override
  State<job> createState() => _jobState();
}

class _jobState extends State<job> with SingleTickerProviderStateMixin {
  late TabController _controller;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    _controller.addListener(() {
      setState(() {
        selectedIndex = _controller.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: Scaffold(
            backgroundColor: Color.fromARGB(255, 18, 27, 34),
            appBar: AppBar(
              title: Text('Jobs',
                  style: TextStyle(color: Color.fromARGB(255, 133, 150, 160))),
              backgroundColor: Color.fromARGB(255, 31, 44, 52),
              bottom: TabBar(
                  indicatorColor: Color.fromARGB(255, 2, 168, 132),
                  tabs: <Widget>[
                    Tab(
                        child: Text('Awaiting',
                            style: TextStyle(
                                color: Color.fromARGB(255, 133, 150, 160)))),
                    Tab(
                        child: Text('Accepted',
                            style: TextStyle(
                                color: Color.fromARGB(255, 133, 150, 160)))),
                    Tab(
                        child: Text('Completed',
                            style: TextStyle(
                                color: Color.fromARGB(255, 133, 150, 160))))
                  ]),
            ),
            body: TabBarView(
              children: <Widget>[
                status(), 
                accepted(),
                complete()])));
  }
}
