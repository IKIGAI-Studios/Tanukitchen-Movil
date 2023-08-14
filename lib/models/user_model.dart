import 'package:mongo_dart/mongo_dart.dart';

class User {
  final ObjectId id;
  final String user;
  final String name;
  final int age;
  final String gender;
  final bool active;
  final int recipes_completed;
  final String? last_recipe;
  //final List? count_recipes;

  const User(
      {required this.id,
      required this.user,
      required this.name,
      required this.age,
      required this.gender,
      required this.active,
      required this.recipes_completed,
      this.last_recipe,
    //  this.count_recipes
});

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'user': user,
      'name': name,
      'age': age,
      'gender': gender,
      'active': active,
      'recipes_completed': recipes_completed,
      'last_recipe': last_recipe
     // 'count_recipes': count_recipes
    };
  }

  User.fromMap(Map<String, dynamic> map)
      : id = map['_id'],
        user = map['user'],
        name = map['name'],
        age = map['age'],
        gender = map['gender'],
        active = map['active'],
        recipes_completed = map['recipes_completed'],
        last_recipe = map['last_recipe'];
      //  count_recipes = map['count_recipes'];
}
