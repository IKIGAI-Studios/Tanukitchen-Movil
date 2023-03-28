import 'dart:async';

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
      final users = await collectionUsers.find().toList();
      return users;
    } catch (e) {
      print(e);
      return Future.value();
    }
  }

  static Future<List<Map<String, dynamic>>> getKitchens() async {
    try {
      final kitchens = await collectionKitchens.find().toList();
      return kitchens;
    } catch (e) {
      print(e);
      return Future.value();
    }
  }

  static Future<List<Map<String, dynamic>>> getRecipes() async {
    try {
      final recipes = await collectionRecipes.find().toList();
      return recipes;
    } catch (e) {
      print(e);
      return Future.value();
    }
  }

  static Future<List<Map<String, dynamic>>> getModules() async {
    try {
      final modules = await collectionModules.find().toList();
      return modules;
    } catch (e) {
      print(e);
      return Future.value();
    }
  }

  static Stream<List<Map<String, dynamic>>> getModulesStream() {
    var controller = StreamController<List<Map<String, dynamic>>>();

    collectionModules.find().listen((modules) {
      controller.add(modules);
    }, onError: (error) {
      controller.addError(error);
    }, onDone: () {
      controller.close();
    });

    return controller.stream;
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

  static Future<bool> isActive(Module module) async {
    var m = await collectionModules.findOne({'_id': module.id});

    var active = m['active'];
    return active;
  }

// Métodos de updateo
// comentadito se ve más bonito (no creo que cambiemos datos desde la app. O sea, tampoco creo que insertemos ni borremos, pero esos son una sola linea so... ai se kedan xjaksdf)
/*  static updateUser(User user) async {
    var u = await collectionUsers.findOne({'_id': user.id});
    u['type'] = user.type;
    u['name'] = user.name;
    u['active'] = user.active;
    await collectionUsers.save(u);
  }
*/

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

// Pos pa borrar
  static deleteUser(User user) async {
    await collectionUsers.remove(where.id(user.id));
  }

  static Stream<List<Map<String, dynamic>>> getModulesAsStream() {
    var controller = StreamController<List<Map<String, dynamic>>>();
    collectionModules.find().listen((data) => controller.add(data));
    return controller.stream;
  }
}

/*
 BIBLIOGRAFÍA
 mongo_dart | Dart Package. (n.d.). Dart Packages. https://pub.dev/packages/mongo_dart
 Luis Serrano Donaire. (2022, January 5). 23. Curso de FLUTTER: MongoDB [Video]. YouTube. https://www.youtube.com/watch?v=b3ZCYY3bIhg

 se cayo chat gaipt
*/
