import 'package:mongo_dart/mongo_dart.dart';

class User {
  final ObjectId id;
  final ObjectId id_kitchen;
  final String user;
  final String name;
  final int age;
  final String gender;
  final String last_recipe;
  final int recipes_completed;
  final bool active;

  const User(
      {required this.id,
      required this.id_kitchen,
      required this.user,
      required this.name,
      required this.age,
      required this.gender,
      required this.last_recipe,
      required this.recipes_completed,
      required this.active});

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'id_kitchen': id_kitchen,
      'user': user,
      'name': name,
      'age': age,
      'gender': gender,
      'last_recipe': last_recipe,
      'recipes_completed': recipes_completed,
      'active': active
    };
  }

  User.fromMap(Map<String, dynamic> map)
      : id = map['_id'],
        id_kitchen = map['id_kitchen'],
        user = map['user'],
        name = map['name'],
        age = map['age'],
        gender = map['gender'],
        last_recipe = map['last_recipe'],
        recipes_completed = map['recipes_completed'],
        active = map['active'];
}
