import 'package:flutter/material.dart';

//import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new Names(
        pageName: "Facebook Code Test",
      ),
    );
  }
}

class Names extends StatefulWidget {
  final String pageName;

  const Names({Key key, this.pageName}) : super(key: key);

  @override
  _NamesState createState() => _NamesState();
}

class _NamesState extends State<Names> {
  List<Name> _names = new List();
  List<Widget> _namesTiles = new List();
  String uriString =
      "mongodb://DATABASESERVER:27017/rpc1";
  String collectionName = "names";

  @override
  void initState() {
    super.initState();
    _getNames();
  }

  _getNames() async {
/*    mongo.Db db = new mongo.Db(uriString);
    var collection = db.collection(collectionName);
    await db.open();
    await collection.find().forEach((map) {
      Name name = new Name()
          ..firstName = map['firstName']
          ..lastName = map['lastName'];
      _names.add(name);
    }); */
    http.Response response = await http.get("http://SERVICEIP:8000/list");
      String body = response.body;
      List data = jsonDecode(body);
      for (Map raw in data) {
        Name name = new Name()
          ..firstName = raw['firstName']
          ..lastName = raw['lastName'];
 //       print("Received $name");
        _names.add(name);
      }
 //   print("received $_names");

    setState(() {
      for (Name found in _names) {
        Text text = new Text("$found");
        _namesTiles.add(text);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: Text(widget.pageName),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => _namesTiles[index],
        itemCount: _namesTiles.length,
      ),
    );
  }
}

class Name {
  String firstName;
  String lastName;

  @override
  String toString() {
    // TODO: implement toString
    return "$firstName $lastName";
  }
}
