import 'package:mongo_dart/mongo_dart.dart';
import 'package:tanukitchen/models/user_model.dart';
import 'package:tanukitchen/models/module_model.dart';
import 'package:tanukitchen/utilities/consts.dart';

class MongoDB {
  static var db,
      collectionUsers,
      collectionKitchens,
      collectionRecipes,
      collectionModules;

  static connect() async {
    db = await Db.create(CONN);
    await db.open();
    collectionUsers = db.collection(COLLECTION_USERS);
    collectionKitchens = db.collection(COLLECTION_KITCHENS);
    collectionRecipes = db.collection(COLLECTION_RECIPES);
    collectionModules = db.collection(COLLECTION_MODULES);
  }

// GETTERS

  static Future<List<Map<String, dynamic>>> getUsers() async {
    try {
      final users = await collectionUsers.find({'active': true}).toList();
      return users;
    } catch (e) {
      return Future.value();
    }
  }

  static Future<List<Map<String, dynamic>>> getKitchens() async {
    try {
      final kitchens = await collectionKitchens.find().toList();
      return kitchens;
    } catch (e) {
      return Future.value();
    }
  }

  static Future<List<Map<String, dynamic>>> getRecipes() async {
    try {
      final recipes = await collectionRecipes.find().toList();
      return recipes;
    } catch (e) {
      return Future.value();
    }
  }

  static Future<List<Map<String, dynamic>>> getModules() async {
    try {
      final modules = await collectionModules.find().toList();
      return modules;
    } catch (e) {
      return Future.value();
    }
  }

// Métodos de inserción (no creo que ocupemos xd)
  static insertUser(User user) async {
    await collectionUsers.insertAll([user.toMap()]);
  }

// Obtener receta favorita
  static Future<String> getFavorite(User user) async {
    var u = await collectionUsers.findOne({'_id': user.id});

    var maxCount = 0;
    var favoriteRecipe = "";
    for (var countRecipe in u['count_recipes']) {
      if (countRecipe['count'] > maxCount) {
        maxCount = countRecipe['count'];
        favoriteRecipe = countRecipe['name'];
      }
    }
    return favoriteRecipe;
  }

  // Obtener detección promedio de humo
  static Future<double> avgValue(Module module) async {
    var m = await collectionModules.findOne({'_id': module.id});

    var c = 0;
    var avg = 0.0;
    for (var value in m['values']) {
      avg = avg + value['value'];
      c++;
    }
    var res = avg / c;
    var roundedRes = res.roundToDouble();
    return roundedRes;
  }

  // Obtener detección promedio de humo
  static Future<double> electricUsage(Module module) async {
    var m = await collectionModules.findOne({'_id': module.id});

    var sec = m['time_usage']['seconds'];
    var horas = sec / 3600;
    var kwh = horas * .5;
    var consumo = kwh * .97;

    return consumo.roundToDouble();
  }

  static Future<bool> isActive(Module module) async {
    var m = await collectionModules.findOne({'_id': module.id});

    var active = m['active'];
    return active;
  }

// Métodos de updateo
// comentadito se ve más bonito (no creo que cambiemos datos desde la app. O sea, tampoco creo que insertemos ni borremos, pero esos son una sola linea so... ai se kedan xjaksdf)
// Update: pos si los usamos xd
  static updateUser(User user) async {
    var u = await collectionUsers.findOne({'_id': user.id});
    u['user'] = user.user;
    u['name'] = user.name;
    u['gender'] = user.gender;
    u['age'] = user.age;

    await collectionUsers.save(u);
  }

// Actualizar estado (encendido o apagado) de los módulos
  static updateModuleState(Module module) async {
    var m = await collectionModules.findOne({'_id': module.id});
    if (m['active'] == true) {
      m['active'] = false;
    } else {
      m['active'] = true;
    }
    await collectionModules.save(m);
  }

  static updateUserState(User user) async {
    var usr = await collectionUsers.findOne({'_id': user.id});
    if (usr['active']) usr['active'] = false;

    await collectionUsers.save(usr);
  }

// Pos pa borrar
  static deleteUser(User user) async {
    await collectionUsers.remove(where.id(user.id));
  }
}

/*
 BIBLIOGRAFÍA
 mongo_dart | Dart Package. (n.d.). Dart Packages. https://pub.dev/packages/mongo_dart
 Luis Serrano Donaire. (2022, January 5). 23. Curso de FLUTTER: MongoDB [Video]. YouTube. https://www.youtube.com/watch?v=b3ZCYY3bIhg

 se cayo chat gaipt
*/
