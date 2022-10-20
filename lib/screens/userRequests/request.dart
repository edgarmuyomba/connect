import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker_widget/date_time_picker_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/professional.dart';
import 'package:flutter_application_1/models/spinkit.dart';
import 'package:flutter_application_1/screens/messaging/proProfile.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_1/main.dart';

class request extends StatefulWidget {
  const request({super.key, required this.professional});

  final Professional professional;

  @override
  State<request> createState() => _requestState();
}

class _requestState extends State<request> {
  String? date, time;
  DateTime dt = DateTime.now();
  final formKey = GlobalKey<FormState>();
  final locationController = TextEditingController();
  final detailController = TextEditingController();
  final descrController = TextEditingController();

  void pushproProfile(Professional pro) {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) {
      return proProfile(professional: pro);
    }));
  }

  @override
  void dispose() {
    locationController.dispose();
    detailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Submit request'), actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.check),
            tooltip: 'submit',
            onPressed: () => makeRequest(widget.professional),
          ),
        ],
        backgroundColor: Color.fromARGB(255, 31, 44, 52),),
        backgroundColor: Color.fromARGB(255, 57, 91, 100),
        body: Padding(
          padding: EdgeInsets.all(5),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(widget.professional.image),
                      radius: 30,
                    ),
                    Expanded(
                        child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      widget.professional.name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Color.fromARGB(255, 231, 246, 242)
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      widget.professional.Category,
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 165, 201, 202)
                                      )
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    ElevatedButton(
                                        onPressed: () =>
                                            pushproProfile(widget.professional),
                                        child: const Text('Profile'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Color.fromARGB(255, 31, 44, 52),
                                        ))
                                  ],
                                ),
                              ],
                            ))),
                  ],
                ),
                SizedBox(height: 7),
                Divider(height: 2),
                DateTimePicker(
                  type: DateTimePickerType.Both,
                  initialSelectedDate: dt.add(Duration(days: 1)),
                  startDate: dt,
                  endDate: dt.add(Duration(days: 365)),
                  startTime: DateTime(dt.year, dt.month, dt.day, 6),
                  endTime: DateTime(dt.year, dt.month, dt.year, 18),
                  timeInterval: Duration(minutes: 15),
                  timeOutOfRangeError: "Sorry, can't pick the selected date",
                  onDateChanged: (value) {
                    setState(
                        (() => {date = DateFormat('yyyy-dd-MM').format(value)}));
                  },
                  onTimeChanged: (value) {
                    setState(() => {time = DateFormat.Hms().format(value)});
                  },
                ),
                SizedBox(height: 7),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        style: TextStyle(color: Color.fromARGB(255, 165, 201, 202)),
                        controller: locationController,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(labelText: 'Location', labelStyle: TextStyle(color: Color.fromARGB(255, 231, 246, 242))),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) =>
                            value != null ? null : 'This is a required field',
                      ),
                      SizedBox(height: 4),
                      TextFormField(
                        style: TextStyle(color: Color.fromARGB(255, 165, 201, 202)),
                        controller: detailController,
                        textInputAction: TextInputAction.done,
                        decoration:
                            InputDecoration(labelText: 'Details e.g main gate', labelStyle: TextStyle(color: Color.fromARGB(255, 231, 246, 242))),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) =>
                            value != null ? null : 'This is a required field',
                      ),
                      SizedBox(height: 4),
                      TextFormField(
                        style: TextStyle(color: Color.fromARGB(255, 165, 201, 202)),
                        controller: descrController,
                        textInputAction: TextInputAction.done,
                        decoration:
                            InputDecoration(labelText: 'Job description', labelStyle: TextStyle(color: Color.fromARGB(255, 231, 246, 242))),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) =>
                            value != null ? null : 'This is a required field',
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Future makeRequest(Professional pro) async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: spinkit),
    );

    try {
      var user = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance.collection('requests')
      .doc(date.toString().trim()+time.toString().trim())
      .set({
        'uniqueId': pro.email.trim(),
        'recepient': pro.name.trim(),
        'request': user!.email,
        'date': date,
        'time': time,
        'location': locationController.text.trim(),
        'details': detailController.text.trim(),
        'status': 'Pending',
        'decription': descrController.text.trim()
      });
    } catch (e) {
      print(e);
    }
    // navigatorKey.currentState!.popUntil((route) => route.isFirst);
    Navigator.pop(context);
  }
}
