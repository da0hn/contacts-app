import 'package:contacts_app_client/contacts_api_client.dart';
import 'package:flutter/material.dart';

class ContactOptionsScreen extends StatelessWidget {
  final ContactRestApi rest;
  final ContactSocketApi socket;

  const ContactOptionsScreen({
    Key? key,
    required this.rest,
    required this.socket,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContactRestScreen(api: rest),
                ),
              );
            },
            text: 'Contacts Using REST',
          ),
          const SizedBox(width: 50, height: 50),
          _buildButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContactSocketScreen(api: socket),
                ),
              );
            },
            text: 'Contacts Using WebSocket',
          ),
        ],
      ),
    );
  }

  ElevatedButton _buildButton({
    required VoidCallback onPressed,
    required String text,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.pink,
        fixedSize: const Size(300, 50),
        shadowColor: Colors.blue[200],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        alignment: Alignment.center,
        textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
