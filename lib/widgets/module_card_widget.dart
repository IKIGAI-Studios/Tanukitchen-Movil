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
      elevation: 15.0,
      shadowColor: Color.fromRGBO(22, 36, 44, 1),
      margin: const EdgeInsets.fromLTRB(10, 20, 10, 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Expanded(
                  child: FractionallySizedBox(
                    widthFactor: 0.70,
                    child: Image(
                      image: AssetImage('assets/images/TakumiWinkWhite.png'),
                    ),
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
                      Text(
                        '${module.id}',
                        textAlign: TextAlign.start,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return PanelPage();
                          }));
                        },
                        color: Color.fromRGBO(6, 190, 182, 1.0),
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
