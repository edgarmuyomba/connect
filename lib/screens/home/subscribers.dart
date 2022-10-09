import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/professional.dart';
import 'package:flutter_application_1/screens/messaging/proProfile.dart';
import 'package:flutter_application_1/screens/request/request.dart';

class subscribers extends StatefulWidget {
  const subscribers({super.key, required this.category});

  final String category;
  @override
  State<subscribers> createState() => _subscribersState();
}

class _subscribersState extends State<subscribers> {
  void pushproProfile(Professional pro) {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) {
      return proProfile(professional: pro);
    }));
  }

  double rating(List ratingList) {
    if (ratingList.length > 0) {
      int len = ratingList.length;
      int sum = 0;
      for (int i in ratingList) {
        sum += i;
      }
      return sum / len;
    }
    return 0.0;
  }

  void pushRequest(Professional pro) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return request(professional: pro);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.category)),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .where('Category', isEqualTo: widget.category)
                .snapshots(),
            builder: ((context, snapshot) {
              return (snapshot.connectionState == ConnectionState.waiting)
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var data = snapshot.data!.docs[index].data()
                            as Map<String, dynamic>;
                        return Card(
                            child: ListTile(
                          title: Text(
                              data['firstname'] + ' ' + data['lastname'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(data['image']),
                          ),
                          subtitle: Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Color.fromARGB(255, 248, 226, 31),
                              ),
                              Text(rating(data['ratings']).toStringAsFixed(1) +
                                  '/5 stars')
                            ],
                          ),
                          onTap: () => pushRequest(Professional(
                              data['firstname'] + ' ' + data['lastname'],
                              data['email'],
                              data['Category'],
                              data['Contact'],
                              data['Location'],
                              data['image'],
                              data['ratings'],
                              data['cost'],
                              data['available'],
                              data['verified'],
                              data['complete'])),
                        ));
                      });
            })));
  }
}
