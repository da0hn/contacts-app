import 'dart:convert';
import 'dart:io';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class ContactsRestApi {
  DbCollection store;

  final _CONTENT_TYPE_JSON = {'Content-Type': ContentType.json.mimeType};

  ContactsRestApi(this.store);

  Handler get router {
    final router = Router();
    router.get('/', (request) async {
      final contacts = await store.find().toList();
      return Response.ok(
        json.encode({'contacts': contacts}),
        headers: _CONTENT_TYPE_JSON,
      );
    });
    router.post('/', (Request request) async {
      final payload = await request.readAsString();
      final data = json.decode(payload);

      await store.insert(data);

      final addedEntry = await store.findOne(where.eq('name', data['name']));
      return Response(
        HttpStatus.created,
        body: json.encode(addedEntry),
        headers: _CONTENT_TYPE_JSON,
      );
    });
    return router;
  }
}
