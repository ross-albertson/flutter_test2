import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_rest/shelf_rest.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'dart:convert';

main() {
  var myRouter = router()
      ..get("/list", (Request request) async {
        List<Map> list = new List();
        mongo.Db database = new mongo.Db('mongodb://SAFELOCALADDRESS:27017/rpc1');
        mongo.DbCollection collection = database.collection('names');
        await database.open();
        await collection.find().forEach((Map map) {
          list.add(map);

        });
        await database.close();
        return new Response.ok(jsonEncode(list));
      });
  io.serve(myRouter.handler, "SERVICEIP", 8000);
}
