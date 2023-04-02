import 'package:mongo_dart/mongo_dart.dart';

class Kitchen {
  final ObjectId id;
  final String name;
  final String password;
  final bool active;

  const Kitchen(
      {required this.id,
      required this.name,
      required this.password,
      required this.active});

  Map<String, dynamic> toMap() {
    return {'_id': id, 'name': name, 'password': password, 'active': active};
  }

  Kitchen.fromMap(Map<String, dynamic> map)
      : id = map['_id'],
        name = map['name'],
        password = map['password'],
        active = map['active'];
}
