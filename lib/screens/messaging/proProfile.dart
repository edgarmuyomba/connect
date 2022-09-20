import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect/models/professional.dart';
import 'package:connect/screens/messaging/inbox.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class proProfile extends StatefulWidget {
  const proProfile({super.key, required this.professional});

  final Professional professional;

  @override
  State<proProfile> createState() => _proProfileState();
}

class _proProfileState extends State<proProfile> {
  final _textController = TextEditingController();

  void pushInbox(Professional pro) {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) {
      return Inbox(
        professional: pro,
      );
    }));
  }

  Future<void> _addReview() async {
    final user = FirebaseAuth.instance.currentUser;
    final _user = FirebaseFirestore.instance
        .collection('ordinary')
        .where('uniqueId' == user!.uid) as Map<String, dynamic>;
    await showModalBottomSheet(
        isScrollControlled: false,
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _textController,
                  decoration: const InputDecoration(labelText: 'Review'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text("Post"),
                  onPressed: () async {
                    final String text = _textController.text;
                    if (text != null) {
                      await FirebaseFirestore.instance
                          .collection('reviews')
                          .add({
                        "contents": text,
                        "uniqueId": user.uid,
                        "sender": _user['firstname'] + ' ' + _user['lastname']
                      });

                      _textController.text = '';
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.professional.name),
      ),
      body: Center(
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/proProfile.png'),
              radius: 150,
            ),
            Text(widget.professional.name),
            Text(widget.professional.Profession),
            Text(widget.professional.Location),
            Text(widget.professional.email),
            Text(widget.professional.Contact),
            ElevatedButton(
                onPressed: () => pushInbox(widget.professional),
                child: Text('Chat')),
            Divider(
              height: 1,
            ),
            Row(
              children: [
                Text('25 Ratings:', style: TextStyle(fontSize: 15)),
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
              ],
            ),
            Text(
              'Reviews',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('reviews').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                      return Card(
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          title: Text(documentSnapshot['content']),
                          subtitle: Text(documentSnapshot['sender']),
                        ),
                      );
                    },
                  );
                }
                return Text('No reviews!');
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addReview(),
        child: Icon(Icons.reviews),
      ),
    );
  }
}
