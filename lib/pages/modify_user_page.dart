import 'package:flutter/material.dart';
import 'package:tanukitchen/models/user_model.dart';

class ModifyUserPage extends StatefulWidget {
  final User? user;
  const ModifyUserPage({Key? key, this.user}) : super(key: key);

  @override
  State<ModifyUserPage> createState() => _ModifyUserPageState();
}

class _ModifyUserPageState extends State<ModifyUserPage> {
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
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
