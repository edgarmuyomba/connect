import 'package:connect/screens/messaging/proProfile.dart';
import 'package:connect/models/professional.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Inbox extends StatefulWidget {
  final Professional professional;

  const Inbox({
    super.key,
    required this.professional,
  });

  @override
  State<Inbox> createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  void callEmoji() {
    print('Emoji Icon Pressed...');
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
          color: Colors.blue,
        ),
        onPressed: () => callEmoji());
  }

  Widget attachFile() {
    return IconButton(
      icon: const Icon(Icons.attach_file, color: Colors.blue),
      onPressed: () => callAttachFile(),
    );
  }

  Widget camera() {
    return IconButton(
      icon: const Icon(Icons.photo_camera, color: Colors.blue),
      onPressed: () => callCamera(),
    );
  }

  Widget voiceIcon() {
    return const Icon(
      Icons.keyboard_voice,
      color: Colors.white,
    );
  }

  void pushproProfile(Professional pro) {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) {
      return proProfile(professional: pro);
    }));
  }

  @override
  Widget build(BuildContext context) {
    final Uri _url = Uri.parse(widget.professional.Contact);
    final Uri _email = Uri.parse(
        'mailto:' + widget.professional.email + '?subject=%20&body=%20');

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
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/proProfile.png'),
            ),
            Text(widget.professional.name),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () => _makePhoneCall(), icon: Icon(Icons.phone)),
          PopupMenuButton(
              color: Color.fromARGB(255, 31, 44, 52),
              onSelected: (result) {
                if (result == 'Profile') {
                  pushproProfile(widget.professional);
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                    PopupMenuItem(
                      value: "Profile",
                      child: Text(
                        "Profile",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
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
      bottomNavigationBar: BottomAppBar(
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
                        offset: Offset(0, 2), blurRadius: 7, color: Colors.grey)
                  ],
                ),
                child: Row(
                  children: [
                    moodIcon(),
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Message",
                            hintStyle: TextStyle(color: Colors.blue),
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
                  color: Colors.blue, shape: BoxShape.circle),
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
