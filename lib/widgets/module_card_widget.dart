import 'package:tanukitchen/db/mongodb.dart';
import 'package:tanukitchen/models/module_model.dart';
import 'package:flutter/material.dart';

class ModuleCard extends StatefulWidget {
  //const ModuleCard({super.key});
  ModuleCard({required this.module, required this.value, this.status});
  final Module module;
  final double value;
  bool? status;

  @override
  State<ModuleCard> createState() => _ModuleCardState();
}

class _ModuleCardState extends State<ModuleCard> {
  late bool active = false;

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
                        (() {
                          switch (widget.module.name) {
                            case "smoke_detector":
                              return "Smoke Detector";
                            case "scale":
                              return "Scale";
                            case "stove":
                              return "Stove";
                            case "extractor":
                              return "Extractor";
                            default:
                              return widget.module.name;
                          }
                        })(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Color.fromRGBO(6, 190, 182, 1.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: _setValue(widget.module.name, widget.value),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(children: [
                            _setStatus(widget.status),
                            if (widget.module.name != "smoke_detector")
                              Switch(
                                  activeColor:
                                      const Color.fromRGBO(6, 190, 182, 1.0),
                                  hoverColor:
                                      const Color.fromRGBO(6, 190, 182, .5),
                                  value: widget.status ?? false,
                                  onChanged: (bool value) {
                                    setState(() {
                                      widget.status = value;
                                    });
                                    // await MongoDB.updateModuleState(
                                    //   widget.module);
                                  })
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
      image: AssetImage('assets/images/${moduleName}_white.png'),
    );
  }

  Widget _setValue(String? moduleName, double? value) {
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

    return style != null ? style(value) : const Text('');
  }
}
