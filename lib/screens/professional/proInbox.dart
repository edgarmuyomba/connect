import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/user.dart';

class proInbox extends StatefulWidget {
  final User user;

  const proInbox({
    super.key,
    required this.user,
  });

  @override
  State<proInbox> createState() => _proInboxState();
}

class _proInboxState extends State<proInbox> {
  void callEmoji() {
    print('Emoji Icon Pressed....');
  }

  void callAttachFile() {
    print('Attach File Icon Pressed...');
  }

  void callCamera() {
    print('Camera Icon Pressed...');
  }

  void callVoice() {
    print('Voice Icon Pressed...');
  }

  Widget moodIcon() {
    return IconButton(
        icon: const Icon(
          Icons.mood,
          color: Color.fromARGB(255, 2, 168, 132),
        ),
        onPressed: () => callEmoji());
  }

  Widget attachFile() {
    return IconButton(
      icon: const Icon(Icons.attach_file,
          color: Color.fromARGB(255, 2, 168, 132)),
      onPressed: () => callAttachFile(),
    );
  }

  Widget camera() {
    return IconButton(
      icon: const Icon(Icons.photo_camera,
          color: Color.fromARGB(255, 2, 168, 132)),
      onPressed: () => callCamera(),
    );
  }

  Widget voiceIcon() {
    return const Icon(
      Icons.keyboard_voice,
      color: Color.fromARGB(255, 2, 168, 132),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Uri _url = Uri.parse(widget.user.Contact);
    final Uri _email =
        Uri.parse('mailto:' + widget.user.email + '?subject=%20&body=%20');

    Future<void> _makePhoneCall() async {
      if (!await launchUrl(_url)) {
        throw 'Could not launch $_url';
      }
    }

    Future<void> _sendEmail() async {
      if (!await launchUrl(_email)) {
        throw 'Could not launch $_email';
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 31, 44, 52),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(widget.user.image),
            ),
            Text(' ' + widget.user.name, style: TextStyle(color: Colors.white)),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () => _makePhoneCall(), icon: Icon(Icons.phone)),
          PopupMenuButton(
              color: Color.fromARGB(255, 31, 44, 52),
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                    PopupMenuItem(
                      value: "Settings",
                      child: Text(
                        "Settings",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    PopupMenuItem(
                      value: "Email",
                      child: Text(
                        "Email",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      onTap: () => _sendEmail(),
                    ),
                  ]),
        ],
      ),
      backgroundColor: Color.fromARGB(255, 12, 19, 23),
      bottomNavigationBar: BottomAppBar(
          color: Color.fromARGB(255, 31, 44, 52),
          child: Container(
            margin: const EdgeInsets.all(12.0),
            height: 60,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(35.0),
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0, 2),
                            blurRadius: 7,
                            color: Colors.grey)
                      ],
                    ),
                    child: Row(
                      children: [
                        moodIcon(),
                        const Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: "Message",
                                hintStyle: TextStyle(
                                    color: Color.fromARGB(255, 2, 168, 132)),
                                border: InputBorder.none),
                          ),
                        ),
                        attachFile(),
                        camera(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 12, 19, 23),
                      shape: BoxShape.circle),
                  child: InkWell(
                    child: voiceIcon(),
                    onLongPress: () => callVoice(),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
