import 'package:contacts_app_client/contacts_api_client.dart';
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
      body: Container(
        color: Colors.black38,
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

  FloatingActionButton _buildRefreshButton() {
    return FloatingActionButton(
      onPressed: () {
        _fetchContacts();
      },
      tooltip: 'Refresh list',
      backgroundColor: Colors.purple,
      child: const Icon(Icons.refresh),
    );
  }

  FloatingActionButton _buildAddContactButton() {
    return FloatingActionButton(
      onPressed: () {},
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
}
