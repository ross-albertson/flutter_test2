# flutter_test2

A new Flutter project.

## Getting Started

For help getting started with Flutter, view our online
[documentation](https://flutter.io/).

You can install MongoDB from [this link](https://www.mongodb.com).
Run the <code>mongod</code> with no arguments.
You will need to

<code>dart bin/service.dart</code>

before running <code>flutter run</code>

In this code I tested the optional "new" feature. In some places leaving "new"out actually does work.
One last thing I learned is the mongo_dart package will only work server side in the lastest version of Flutter/Dart. I created a Shelf REST service that transmits a list of names from MongoDB as a JSON string. The device uses The HTTP package to retreive the String, which JSON and OOP parses into a list of names. Lastly, those names are automatically formatted and turned into Text widgets 
