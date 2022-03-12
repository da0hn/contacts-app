import 'package:flutter/material.dart';

class NoContacts extends StatelessWidget {
  final VoidCallback onAdd;

  const NoContacts({required this.onAdd, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.person_outline,
            size: 80,
            color: Colors.black45,
          ),
          const Text(
            'No contacts listed',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 20),
          MaterialButton(
            onPressed: () => this.onAdd(),
            color: Colors.purple,
            child: const Text(
              'Add your first',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
