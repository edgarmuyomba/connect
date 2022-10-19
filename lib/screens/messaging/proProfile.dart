// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:rating_dialog/rating_dialog.dart';
import '../../models/professional.dart';
import 'inbox.dart';

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

  String comment(double rate) {
    if (rate >= 4.5) {
      return 'Excellent';
    } else if (rate >= 4) {
      return 'Good';
    } else {
      return 'Fair';
    }
  }

  Widget tags(int jobs, double rate) {
    if (jobs >= 20) {
      return Row(
        children: [
          Container(
            width: 90,
            height: 30,
            decoration: ShapeDecoration(
                color: Color.fromARGB(255, 7, 116, 11),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                    side: BorderSide(
                      width: 1,
                      color: Color.fromARGB(255, 7, 116, 11),
                    ))),
            child: Center(
              child: Text(
                'Verified',
                style: TextStyle(color: Color.fromARGB(255, 122, 250, 126)),
              ),
            ),
          ),
          SizedBox(width: 5),
          Container(
            width: 90,
            height: 30,
            decoration: ShapeDecoration(
                color: Colors.grey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                    side: BorderSide(
                      width: 1,
                      color: Colors.grey,
                    ))),
            child: Center(
              child: Text(comment(rate)),
            ),
          )
        ],
      );
    } else {
      return Row(
        children: [
          Container(
            width: 90,
            height: 30,
            decoration: ShapeDecoration(
                color: Color.fromARGB(255, 131, 9, 0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                    side: BorderSide(
                      width: 1,
                      color: Color.fromARGB(255, 131, 9, 0),
                    ))),
            child: Center(
              child: Text('Unverified',
                  style: TextStyle(color: Color.fromARGB(255, 255, 114, 104))),
            ),
          ),
          SizedBox(width: 5),
          Container(
            width: 90,
            height: 30,
            decoration: ShapeDecoration(
                color: Colors.grey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                    side: BorderSide(
                      width: 1,
                      color: Colors.grey,
                    ))),
            child: Center(
              child: Text(comment(rate)),
            ),
          )
        ],
      );
    }
  }

  Widget availability(bool state) {
    if (state == true) {
      return Row(
        children: [
          GlowIcon(
            Icons.circle,
            color: Color.fromARGB(255, 37, 145, 41),
            glowColor: Color.fromARGB(255, 88, 180, 91),
            size: 10,
            blurRadius: 4,
          ),
          Text(' Available now')
        ],
      );
    } else {
      return Row(
        children: [
          GlowIcon(
            Icons.circle,
            color: Color.fromARGB(255, 231, 25, 10),
            glowColor: Color.fromARGB(255, 243, 78, 66),
            size: 10,
            blurRadius: 4,
          ),
          Text(' Unavailable')
        ],
      );
    }
  }

  Future<void> _addReview() async {
    final user = FirebaseAuth.instance.currentUser;
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
                        "content": text,
                        "uniqueId": user!.uid,
                        "sender": user.email
                            .toString()
                            .substring(0, user.email.toString().indexOf('@')),
                        "receipient": widget.professional.name,
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

  Widget _dialog() {
    final user = FirebaseAuth.instance.currentUser;
    return RatingDialog(
      initialRating: 1.0,
      title: Text(
        'Connect',
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      message: Text(
        'Tap a star to set your rating. Add a review about the professional here if you want.',
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 15),
      ),
      image: Image.asset('./assets/logo.png'),
      submitButtonText: 'Submit',
      commentHint: 'Submit a review',
      onCancelled: () => Navigator.pop(context),
      onSubmitted: (response) async {
        print('rating: ${response.rating}, comment: ${response.comment}');
        await FirebaseFirestore.instance.collection('reviews').add({
          "content": response.comment,
          "uniqueId": user!.uid,
          "sender": user.email
              .toString()
              .substring(0, user.email.toString().indexOf('@')),
          "receipient": widget.professional.name,
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.professional.name),
        backgroundColor: Color.fromARGB(255, 3, 26, 36),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.asset(widget.professional.image,
                      height: 150, width: 150),
                ),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.professional.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            widget.professional.Category,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Color.fromARGB(255, 248, 226, 31),
                          ),
                          Text(rating(widget.professional.ratings)
                                  .toStringAsFixed(1) +
                              '/5 stars')
                        ],
                      ),
                      availability(widget.professional.available),
                      Row(
                        children: [
                          ElevatedButton(
                              onPressed: () => pushInbox(widget.professional),
                              child: Text('Chat')),
                        ],
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'UGX ' + widget.professional.cost.toString(),
                      style: TextStyle(fontSize: 22),
                    )
                  ],
                ),
                Row(
                  children: [Text('Starting cost\n')],
                ),
                tags(widget.professional.complete,
                    rating(widget.professional.ratings)),
                Row(
                  children: [
                    Text(
                      '\nAbout this pro',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ],
                ),
                Text(
                    'This professional has a work experience of over 5 years and is guaranteed to get the job properly done.'),
              ],
            ),
          ),
          Divider(
            height: 1,
          ),
          Text(
            'Reviews',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('reviews')
                .where('receipient', isEqualTo: widget.professional.name)
                .snapshots(),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addReview(),
        child: Icon(Icons.reviews),
        backgroundColor: Color.fromARGB(255, 3, 26, 36),
      ),
    );
  }
}
