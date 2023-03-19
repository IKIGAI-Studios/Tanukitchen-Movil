import 'package:mongo_dart/mongo_dart.dart';

class Module {
  final ObjectId id;
  final String id_kitchen;
  final String name;
  final bool active;
  final double? lastValue;

  const Module(
      {required this.id,
      required this.id_kitchen,
      required this.name,
      required this.active,
      this.lastValue});

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'id_kitchen': id_kitchen,
      'name': name,
      'active': active
    };
  }

  Module.fromMap(Map<String, dynamic> map)
      : id = map['_id'],
        id_kitchen = map['id_kitchen'],
        name = map['name'],
        lastValue = map['values']?.last['value']?.toDouble(),
        active = map['active'];
}
