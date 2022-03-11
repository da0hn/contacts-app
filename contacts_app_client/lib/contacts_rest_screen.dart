import 'package:flutter/material.dart';

class ContactRestScreen extends StatefulWidget {
  const ContactRestScreen({Key? key}) : super(key: key);

  @override
  _ContactRestScreenState createState() => _ContactRestScreenState();
}

class _ContactRestScreenState extends State<ContactRestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Contacts App'),
      ),
      body: Container(
        color: Colors.black38,
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {},
            tooltip: 'Refresh list',
            backgroundColor: Colors.purple,
            child: const Icon(Icons.refresh),
          ),
          const SizedBox(height: 10, width: 10),
          FloatingActionButton(
            onPressed: () {},
            tooltip: 'Add new contact',
            child: const Icon(Icons.person_add),
          ),
        ],
      ),
    );
  }
}
