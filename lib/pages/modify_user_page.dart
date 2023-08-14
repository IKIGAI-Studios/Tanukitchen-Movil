import 'package:flutter/material.dart';
import 'package:tanukitchen/models/user_model.dart';
import 'package:tanukitchen/db/mongodb.dart';

class ModifyUserPage extends StatefulWidget {
  final User? user;
  const ModifyUserPage({Key? key, this.user}) : super(key: key);

  @override
  State<ModifyUserPage> createState() => _ModifyUserPageState();
}

class _ModifyUserPageState extends State<ModifyUserPage> {
  final _formKey = GlobalKey<FormState>();
  final userController = TextEditingController();
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final genderController = TextEditingController();

  @override
  void initState() {
    super.initState();

    userController.text = widget.user!.user;
    nameController.text = widget.user!.name;
    ageController.text = widget.user!.age.toString();
    genderController.text = widget.user!.gender;
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
    final screenSize = MediaQuery.of(context).size;
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
                    'Modify Profile',
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
                      height: screenSize.width * .25,
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
                        if (userController.text != widget.user!.user ||
                            nameController.text != widget.user!.name ||
                            ageController.text != widget.user!.age.toString() ||
                            genderController.text != widget.user!.gender) {
                          // Actualizar los datos del usuario en la base de datos
                          User updatedUser = User(
                            id: widget.user!.id,
                            recipes_completed: widget.user!.recipes_completed,
                            active: widget.user!.active,
                            last_recipe: widget.user!.last_recipe,
                            user: userController.text,
                            name: nameController.text,
                            gender: genderController.text,
                            age: int.parse(ageController.text),
                          );
                          Navigator.pop(context);
                          Navigator.pushNamed(context, 'home');
                          await MongoDB.updateUser(updatedUser);
                        } else {
                          const milkyway = SnackBar(
                            content: Text('There is nothing to change'),
                            duration: Duration(seconds: 2),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(milkyway);
                        }
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
