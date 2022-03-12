import 'package:contacts_app_client/contacts_api_client.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

class ContactRestScreen extends StatefulWidget {
  final ContactRestApi api;

  const ContactRestScreen({
    required this.api,
    Key? key,
  }) : super(key: key);

  @override
  _ContactRestScreenState createState() => _ContactRestScreenState();
}

class _ContactRestScreenState extends State<ContactRestScreen> {
  List<Contact> _contacts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Contacts App'),
      ),
      body: _isLoading
          ? _loading()
          : ContactList(
              data: _contacts,
              onAdd: () => _addContact(),
              onDelete: (String id) => _deleteContact(id),
            ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildRefreshButton(),
          const SizedBox(height: 10, width: 10),
          _buildAddContactButton(),
        ],
      ),
    );
  }

  void _deleteContact(String id) async {
    await widget.api.delete(id);
    setState(() {
      _contacts.removeWhere((element) => element.id == id);
    });
  }

  FloatingActionButton _buildRefreshButton() {
    return FloatingActionButton(
      onPressed: () => _fetchContacts(),
      tooltip: 'Refresh list',
      backgroundColor: Colors.purple,
      child: const Icon(Icons.refresh),
    );
  }

  FloatingActionButton _buildAddContactButton() {
    return FloatingActionButton(
      onPressed: () => this._addContact(),
      tooltip: 'Add new contact',
      child: const Icon(Icons.person_add),
    );
  }

  void _fetchContacts() async {
    final contacts = await widget.api.fetch();
    setState(() {
      _contacts = contacts;
      _isLoading = false;
    });
  }

  _loading() {
    return Center(
      child: CircularProgressIndicator(
        color: Colors.red,
      ),
    );
  }

  _addContact() async {
    final faker = Faker();
    final person = faker.person;
    final fullName = '${person.firstName()} ${person.lastName()}';
    final newContact = await widget.api.add(fullName);
    setState(() {
      _contacts.add(newContact);
    });
  }
}
