import 'dart:ffi';

import 'package:mongo_dart/mongo_dart.dart';

class User {
  final ObjectId id;
  final String type;
  final String name;
  final bool active;

  const User(
      {required this.id,
      required this.type,
      required this.name,
      required this.active});

  Map<String, dynamic> toMap() {
    return {'_id': id, 'type': type, 'name': name, 'active': active};
  }

  User.fromMap(Map<String, dynamic> map)
      : id = map['_id'],
        type = map['type'],
        name = map['name'],
        active = map['active'];
}
