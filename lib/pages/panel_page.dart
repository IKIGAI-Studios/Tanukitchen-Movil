import 'package:tanukitchen/widgets/module_card_widget.dart';
import 'package:tanukitchen/models/user_model.dart';
import 'package:tanukitchen/pages/profile_page.dart';
import 'package:tanukitchen/models/module_model.dart';
import 'package:tanukitchen/db/mongodb.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class PanelPage extends StatefulWidget {
  final User user;
  const PanelPage({Key? key, required this.user}) : super(key: key);

  @override
  State<PanelPage> createState() => _PanelPageState();
}

class _PanelPageState extends State<PanelPage> {
  late StreamSubscription _modulesSubscription;
  List<Map<String, dynamic>> _modules = [];

  @override
  void initState() {
    super.initState();
    _modulesSubscription = MongoDB.getModulesStream().listen((modules) {
      setState(() {
        _modules = modules;
      });
    });
  }

  @override
  void dispose() {
    _modulesSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color.fromRGBO(39, 47, 63, 1.0),
        title: const Text(
          'tanukitchen',
          style: TextStyle(
              fontFamily: 'Somatic', color: Color.fromRGBO(217, 217, 217, 1.0)),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (_) => MyProfile(
                          user: widget.user,
                        )),
              );
            },
            child: Row(
              children: [
                Text(widget.user.user),
                const Padding(
                  padding: EdgeInsets.only(left: 15, right: 16),
                  child: CircleAvatar(
                    backgroundColor: Color.fromRGBO(217, 217, 217, 1.0),
                    backgroundImage: AssetImage(
                      'assets/images/pfp.jpg',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 25.0,
          ),
          const Text(
            'Control Panel',
            style: TextStyle(
                color: Color.fromRGBO(217, 217, 217, 1.0),
                fontWeight: FontWeight.bold,
                fontSize: 25.0),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                print(_modules[index]);
                return ModuleCard(
                  module: Module.fromMap(_modules[index]),
                );
              },
              itemCount: _modules.length,
            ),
          ),
        ],
      ),
    );
  }
}
