import 'dart:convert';
import 'dart:io';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class ContactsRestApi {
  DbCollection store;

  ContactsRestApi(this.store);

  Handler get router {
    final router = Router();
    router.get('/', (request) async {
      final contacts = await store.find().toList();
      return Response.ok(
        json.encode({'contacts': contacts}),
        headers: {'Content-Type': ContentType.json.mimeType},
      );
    });
    return router;
  }
}
