import 'package:flutter/material.dart';
import 'package:tanukitchen/models/user_model.dart';
import 'package:tanukitchen/models/kitchen_model.dart';
import 'package:tanukitchen/db/mongodb.dart';
import 'package:bson/bson.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  Kitchen? _firstKitchen;
  final _formKey = GlobalKey<FormState>();
  final userController = TextEditingController();
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final genderController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getFirstKitchen();
  }

  Future<void> _getFirstKitchen() async {
    List kitchens = await MongoDB.getKitchens();
    _firstKitchen = kitchens[0];
  }

  @override
  void dispose() {
    // Limpiar los controladores de texto al salir del formulario
    userController.dispose();
    nameController.dispose();
    ageController.dispose();
    genderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MongoDB.getKitchens();
    final _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          elevation: 0.0,
          backgroundColor: const Color.fromRGBO(39, 47, 63, 1.0),
          title: const Text(
            'Go back',
            style: TextStyle(
                fontFamily: 'Somatic',
                color: Color.fromRGBO(217, 217, 217, 1.0)),
          )),
      body: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Add User',
                    style: TextStyle(
                      color: Color.fromRGBO(217, 217, 217, 1.0),
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                    ),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      'assets/images/pfp.png',
                      height: _screenSize.width * .25,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    style: const TextStyle(
                      color: Color.fromRGBO(217, 217, 217, 1.0),
                    ),
                    controller: userController,
                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(6, 190, 182, 1.0))),
                      labelText: 'Username',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(6, 190, 182, 1.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'The username can not be empty D:';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    style: const TextStyle(
                      color: Color.fromRGBO(217, 217, 217, 1.0),
                    ),
                    keyboardType: TextInputType.name,
                    controller: nameController,
                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(6, 190, 182, 1.0))),
                      labelText: 'Full Name',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(6, 190, 182, 1.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Full name can not be empty D:';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    style: const TextStyle(
                      color: Color.fromRGBO(217, 217, 217, 1.0),
                    ),
                    controller: genderController,
                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(6, 190, 182, 1.0))),
                      labelText: 'Gender',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(6, 190, 182, 1.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'The gender can not be empty D:';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    style: const TextStyle(
                      color: Color.fromRGBO(217, 217, 217, 1.0),
                    ),
                    keyboardType: TextInputType.number,
                    controller: ageController,
                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(6, 190, 182, 1.0))),
                      labelText: 'Age',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(6, 190, 182, 1.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'The age can not be empty D:';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(6, 190, 182, 1.0),
                        elevation: 10.0),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // Actualizar los datos del usuario en la base de datos
                        User newUser = User(
                          id: ObjectId(),
                          recipes_completed: 0,
                          active: true,
                          user: userController.text,
                          name: nameController.text,
                          gender: genderController.text,
                          age: int.parse(ageController.text),
                        );
                        Navigator.pop(context);
                        Navigator.pushNamed(context, 'home');
                        await MongoDB.addUser(newUser);
                      }
                    },
                    child: const Text(
                      'Save changes',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
