import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_web_socket/shelf_web_socket.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Event {
  String action;
  String? payload;

  Event({required this.action, this.payload});

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      action: map['action'] as String,
      payload: map['payload'] as String?,
    );
  }
}

class ContactsSocketApi {
  DbCollection store;

  ContactsSocketApi(this.store);

  Handler get router {
    return webSocketHandler((WebSocketChannel socket) {
      socket.stream.listen((message) async {
        final Event data = Event.fromMap(json.decode(message));

        if (data.action == 'ADD') {
          final newContact = await store.insert({'name': data.payload});
        }

        if (data.action == 'DELETE') {
          await store.deleteOne(
            {'_id': ObjectId.fromHexString(data.payload!)},
          );
        }

        final contacts = await store.find().toList();
        socket.sink.add(json.encode(contacts));
      });
    });
  }
}
