import 'package:contacts_app_client/contacts_api_client.dart';
import 'package:contacts_app_client/src/contact_factory.dart';
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
      heroTag: 'refreshButton',
      backgroundColor: Colors.purple,
      child: const Icon(Icons.refresh),
    );
  }

  FloatingActionButton _buildAddContactButton() {
    return FloatingActionButton(
      onPressed: () => _addContact(),
      tooltip: 'Add new contact',
      heroTag: 'addContact',
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
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.red,
      ),
    );
  }

  _addContact() async {
    var newContactName = makeNewContact();
    final newContact = await widget.api.add(newContactName);
    setState(() {
      _contacts.add(newContact);
    });
  }
}
