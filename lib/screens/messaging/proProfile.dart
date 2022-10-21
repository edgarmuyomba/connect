import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/spinkit.dart';
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
          Text(' Available now', style: TextStyle(color: Colors.green))
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
          Text(' Unavailable', style: TextStyle(color: Colors.red))
        ],
      );
    }
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
      backgroundColor: Color.fromARGB(255, 57, 91, 100),
      body: SingleChildScrollView(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(widget.professional.email)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data!.data() as Map<String, dynamic>;
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(children: [
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
                                            color: Color.fromARGB(
                                                255, 231, 246, 242)),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        widget.professional.Category,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 165, 201, 202),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color:
                                            Color.fromARGB(255, 248, 226, 31),
                                      ),
                                      Text(
                                          rating(data['ratings'])
                                                  .toStringAsFixed(1) +
                                              '/5 stars',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 165, 201, 202)))
                                    ],
                                  ),
                                  availability(data['available']),
                                  Row(
                                    children: [
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Color.fromARGB(
                                                  255, 44, 51, 51)),
                                          onPressed: () =>
                                              pushInbox(widget.professional),
                                          child: Text('Chat')),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ]),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'UGX ' + widget.professional.cost.toString(),
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Color.fromARGB(255, 231, 246, 242)),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Starting cost\n',
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 165, 201, 202)),
                                )
                              ],
                            ),
                            tags(data['complete'], rating(data['ratings'])),
                            Row(
                              children: [
                                Text(
                                  '\nAbout this pro',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color:
                                          Color.fromARGB(255, 231, 246, 242)),
                                ),
                              ],
                            ),
                            StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('bioData')
                                  .doc(data['email'])
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(child: spinkit);
                                } else {
                                  try {
                                    var data = snapshot.data!.data()
                                        as Map<String, dynamic>;
                                    return Text(data['about'],
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 165, 201, 202)));
                                  } catch (e) {
                                    return Container();
                                  }
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 1,
                      ),
                      Text(
                        'Reviews',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 231, 246, 242)),
                      ),
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('reviews')
                            .where('receipient',
                                isEqualTo: widget.professional.name)
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                          if (streamSnapshot.hasData) {
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: streamSnapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                final DocumentSnapshot documentSnapshot =
                                    streamSnapshot.data!.docs[index];
                                return Card(
                                  color: Color.fromARGB(255, 165, 201, 202),
                                  margin: const EdgeInsets.all(10),
                                  child: ListTile(
                                    title: Text(
                                      documentSnapshot['content'],
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 44, 51, 51)),
                                    ),
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
                  );
                } else {
                  return Center(child: spinkit);
                }
              })),
    );
  }
}
