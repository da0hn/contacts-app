import 'dart:async';
import 'dart:convert';

import 'package:contacts_app_client/contacts_api_client.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

class ContactSocketScreen extends StatefulWidget {
  final ContactSocketApi api;

  const ContactSocketScreen({Key? key, required this.api}) : super(key: key);

  @override
  State<ContactSocketScreen> createState() => _ContactSocketScreenState();
}

class _ContactSocketScreenState extends State<ContactSocketScreen> {
  final _socketStream = StreamController<Contacts>();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts App'),
      ),
      body: StreamBuilder<Contacts>(
        initialData: const [],
        stream: _socketStream.stream,
        builder: (_, snapshot) {
          if (_isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return ContactList(
            data: snapshot.data ?? [],
            onAdd: _addContact,
            onDelete: _onDelete,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addContact,
        tooltip: 'Add new contact',
        child: const Icon(Icons.person_add),
      ),
    );
  }

  void _loadContacts() {
    widget.api
      ..stream.listen((contacts) {
        _isLoading = false;
        _socketStream.add(contacts);
      })
      ..send(json.encode({'action': 'LOAD'}));
  }

  void _onDelete(String id) {
    widget.api.send(json.encode({
      'action': 'DELETE',
      'payload': id,
    }));
  }

  void _addContact() {
    final faker = Faker();
    final person = faker.person;
    final fullName = '${person.firstName()} ${person.lastName()}';
    widget.api.send(json.encode({
      'action': 'ADD',
      'payload': fullName,
    }));
  }
}
