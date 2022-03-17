import 'package:flutter/material.dart';

import 'contacts_api_client.dart';

void main() {
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contacts App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ContactOptionsScreen(
        rest: ContactRestApi(),
        socket: ContactSocketApi(),
      ),
    );
  }
}
