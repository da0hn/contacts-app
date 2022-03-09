import 'dart:io';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_hotreload/shelf_hotreload.dart';
import 'package:shelf_router/shelf_router.dart';

main() async {
  final db = await Db.create('mongodb://admin:pass2022@localhost:27018/admin');
  await db.open();
  final contactsCollection = db.collection('contacts');
  print('Database connection opened');

  const port = 8081;
  final router = Router();

  router.get('/', (request) {
    return Response.ok('Hello world');
  });

  final handler = Pipeline().addMiddleware(logRequests()).addHandler(router);

  withHotreload(() => serve(handler, InternetAddress.anyIPv4, port));
}
