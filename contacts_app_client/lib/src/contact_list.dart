import 'package:contacts_app_client/contacts_api_client.dart';
import 'package:flutter/material.dart';

class ContactList extends StatelessWidget {
  final List<Contact> data;
  final ValueChanged<String> onDelete;

  const ContactList({
    required this.data,
    required this.onDelete,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ...data
            .map<Widget>(
              (contact) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                key: ValueKey(contact.id),
                child: ListTile(
                  title: Text(
                    contact.name,
                    style: const TextStyle(fontSize: 20),
                  ),
                  leading: CircleAvatar(
                    radius: 30,
                    child: Text(contact.initials),
                  ),
                  trailing: MaterialButton(
                    onPressed: () => onDelete(contact.id),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 30,
                    ),
                  ),
                ),
              ),
            )
            .toList()
      ],
    );
  }
}
