import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/userRequests/completeTasks.dart';
import 'package:flutter_application_1/screens/userRequests/tasks.dart';

class SentRequest extends StatefulWidget {
  const SentRequest({super.key});

  @override
  State<SentRequest> createState() => _sentRequestState();
}

class _sentRequestState extends State<SentRequest> with SingleTickerProviderStateMixin {
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
        length: 2,
        child: Scaffold(
            backgroundColor: Color.fromARGB(255, 18, 27, 34),
            appBar: AppBar(
              title: Text('Tasks',
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
                        child: Text('Completed',
                            style: TextStyle(
                                color: Color.fromARGB(255, 133, 150, 160)))),
                  ]),
            ),
            body: TabBarView(
              children: <Widget>[
                tasks(), 
                compTasks(),
                ])));
  }
}
