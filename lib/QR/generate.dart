import 'dart:html';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  runApp(const generatepage());
}

class generatepage extends StatelessWidget {
  const generatepage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(title: const Text("SCAN QR CODE")),
          body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Center(
                      child: QrImage(
                          data: 'CSC2022 CSC1202 1',
                          version: QrVersions.auto,
                          size: (200),
                          gapless: false,
                          errorStateBuilder: (cxt, err) {
                            return Container(
                              child: const Center(
                                child: Text(
                                  'Something Went Wrong',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          }),
                    )
                  ])),
            ]),
          ),
        ));
  }
}
