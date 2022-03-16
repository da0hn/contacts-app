import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Contact extends Equatable {
  final String id;
  final String name;
  final String initials;

  const Contact._({
    required this.id,
    required this.name,
    required this.initials,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'initials': initials,
    };
  }

  static _initial(
    List<String> text,
    int index,
  ) {
    if (text.length < index + 1) return '';
    return text[index].substring(0, 1).toUpperCase();
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    final String name = map['name'];
    final splitName = name.split(' ');
    return Contact._(
      id: map['_id'] as String,
      name: name,
      initials: _initial(splitName, 0) + _initial(splitName, 1),
    );
  }

  @override
  String toString() {
    return 'Contact{id: $id, name: $name, initials: $initials}';
  }

  @override
  List<String> get props => [id, name, initials];
}

class ContactRestApi {
  final _api = Dio(BaseOptions(
    baseUrl: 'http://localhost:8081',
    headers: {'Content-Type': ContentType.json.mimeType},
  ));

  Future<List<Contact>> fetch() async {
    final response = await _api.get('/contacts');
    return (response.data['contacts'] as List)
        .map((item) => Contact.fromMap(item))
        .toList();
  }

  Future<Contact> add(String name) async {
    final response = await _api.post(
      '/contacts',
      data: {'name': name},
    );
    return Contact.fromMap(response.data);
  }

  Future delete(String id) => _api.delete('/contacts/$id');
}

typedef Contacts = List<Contact>?;

class ContactSocketApi {
  ContactSocketApi()
      : _api = WebSocketChannel.connect(
          Uri.parse('ws://localhost:8081/contacts-ws'),
        );

  final WebSocketChannel _api;

  Stream<Contacts> get stream => _api.stream.map(
        (data) {
          final decoded = json.decode(data);
          return (decoded as List)
              .map((json) => Contact.fromMap(json))
              .toList();
        },
      );

  ValueChanged<String> get send => _api.sink.add;
}
