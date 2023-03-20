import 'package:tanukitchen/db/mongodb.dart';
import 'package:tanukitchen/models/module_model.dart';
import 'package:flutter/material.dart';

class ModuleCard extends StatefulWidget {
  //const ModuleCard({super.key});
  ModuleCard({required this.module});
  final Module module;

  @override
  State<ModuleCard> createState() => _ModuleCardState();
}

class _ModuleCardState extends State<ModuleCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      color: const Color.fromRGBO(39, 47, 63, 1.0),
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
                    widthFactor: 0.50,
                    child: _setImage(widget.module.name),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.module.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Color.fromRGBO(6, 190, 182, 1.0)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: _setValue(
                            widget.module.name, widget.module.lastValue),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(children: [
                            _setStatus(widget.module.active),
                            Switch(
                              activeColor:
                                  const Color.fromRGBO(6, 190, 182, 1.0),
                              hoverColor: const Color.fromRGBO(6, 190, 182, .5),
                              value: widget.module.active,
                              onChanged: (bool value) async {
                                setState(() {
                                  widget.module.active = value;
                                });
                                await MongoDB.updateModuleState(widget.module);
                              },
                            ),
                          ])),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _setStatus(bool? status) {
    return status == null
        ? const Text('')
        : status == true
            ? const Text(
                'Turned On',
                style: TextStyle(color: Color.fromRGBO(217, 217, 217, 1.0)),
              )
            : const Text('Turned Off',
                style: TextStyle(color: Color.fromRGBO(217, 217, 217, 1.0)));
  }

  Widget _setImage(String? moduleName) {
    return Image(
      image: AssetImage('assets/images/$moduleName' + '_white.png'),
    );
  }

  Widget _setValue(String? moduleName, double? lastValue) {
    final moduleValue = {
      'stove': (value) => Text(
            'Temperature: $value',
            style: const TextStyle(
                fontSize: 15.0, color: Color.fromRGBO(217, 217, 217, 1.0)),
          ),
      'scale': (value) => Text(
            'Weight: $value',
            style: const TextStyle(
                fontSize: 15.0, color: Color.fromRGBO(217, 217, 217, 1.0)),
          ),
      'smoke_detector': (value) => Text(
            'Smoke detected: $value',
            style: const TextStyle(
                fontSize: 15.0, color: Color.fromRGBO(217, 217, 217, 1.0)),
          ),
    };

    final style = moduleValue[moduleName];

    return style != null ? style(lastValue) : const Text('');
  }
}
