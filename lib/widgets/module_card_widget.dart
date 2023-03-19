import 'package:tanukitchen/models/module_model.dart';
import 'package:tanukitchen/pages/panel_page.dart';
import 'package:flutter/material.dart';

class ModuleCard extends StatelessWidget {
//  const UserCard({super.key});
  ModuleCard({required this.module});
  final Module module;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(10, 20, 10, 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: FractionallySizedBox(
                    widthFactor: 0.70,
                    child: _setImage(module.name),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        module.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      _setStatus(module.active),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {},
                        color: const Color.fromRGBO(6, 190, 182, 1.0),
                        icon: const ImageIcon(
                          AssetImage('assets/images/enter.png'),
                        ),
                        tooltip: 'Enter',
                        highlightColor: const Color.fromRGBO(6, 190, 182, .3),
                        splashColor: const Color.fromRGBO(6, 190, 182, .3),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget _setStatus(bool? status) {
  return status == null
      ? const Text('')
      : status == true
          ? const Text('Turn Off')
          : const Text('Turn On');
}

Widget _setImage(String? moduleName) {
  return Image(
    image: AssetImage('assets/images/$moduleName' + '_blue.png'),
  );
}
