import 'package:mongo_dart/mongo_dart.dart';
import 'package:tanukitchen/models/user_model.dart';
import 'package:tanukitchen/utilities/consts.dart';

class MongoDB {
  static var db, collectionUsers;

  static connect() async {
    db = await Db.create(CONN);
    await db.open();
    collectionUsers = db.collection(COLLECTION_USERS);
  }

  static Future<List<Map<String, dynamic>>> getUsers() async {
    try {
      final users = await collectionUsers.find().toList();
      return users;
    } catch (e) {
      print(e);
      return Future.value();
    }
  }

// Insertar usuario
  static insertUser(User user) async {
    await collectionUsers.insertAll([user.toMap()]);
  }

// Updatear usuario
// comentadito se ve más bonito (no creo que cambiemos datos desde la app. O sea, tampoco creo que insertemos ni borremos, pero esos son una sola linea so... ai se kedan xjaksdf)
/*  static updateUser(User user) async {
    var u = await collectionUsers.findOne({'_id': user.id});
    u['type'] = user.type;
    u['name'] = user.name;
    u['active'] = user.active;
    await collectionUsers.save(u);
  }
*/

// Pos deletear usuario xd
  static deleteUser(User user) async {
    await collectionUsers.remove(where.id(user.id));
  }
}


/*
 BIBLIOGRAFÍA
 mongo_dart | Dart Package. (n.d.). Dart Packages. https://pub.dev/packages/mongo_dart
 Luis Serrano Donaire. (2022, January 5). 23. Curso de FLUTTER: MongoDB [Video]. YouTube. https://www.youtube.com/watch?v=b3ZCYY3bIhg
*/