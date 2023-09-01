import 'package:flutter/material.dart';
import 'package:tanukitchen/mqtt/mqtt_manager.dart';
import 'package:tanukitchen/mqtt/mqtt_routes.dart';

class ModuleCard extends StatefulWidget {
  //const ModuleCard({super.key});
  ModuleCard(
      {required this.module_name,
      required this.value,
      this.status,
      required this.mqttManager});  
  final String module_name;
  final double value;
  bool? status;
  final MQTTManager mqttManager;


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
                    child: _setImage(widget.module_name),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.module_name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Color.fromRGBO(6, 190, 182, 1.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: _setValue(widget.module_name, widget.value),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(children: [
                            _setStatus(widget.status),
                            if (widget.module_name != "Smoke Detector")
                              Switch(
                                  activeColor:
                                      const Color.fromRGBO(6, 190, 182, 1.0),
                                  hoverColor:
                                      const Color.fromRGBO(6, 190, 182, .5),
                                  value: widget.status ?? false,
                                  onChanged: (bool value) {
                                    setState(() {
                                      
                                      widget.status = value; 
                                      _updateStatus(widget.module_name,
                                          widget.status, widget.mqttManager);
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

  bool? _updateStatus(moduleName, moduleStatus, mqttManager) {
    if (moduleName == 'Stove' && moduleStatus == true) {
      mqttManager.publishMessage('ON', server_stoveStatus);
      print("Estufa Encendida");
      return false;
    }
    if (moduleName == 'Stove' && moduleStatus == false) {
      mqttManager.publishMessage('OFF', server_stoveStatus);
      print("Estufa Apagada");
      return true;
    }
        if (moduleName == 'Extractor' && moduleStatus == true) {
      mqttManager.publishMessage('ON', server_extractorStatus);
      print("Extractor Encendido");
      return false;
    }
    if (moduleName == 'Extractor' && moduleStatus == false) {
      mqttManager.publishMessage('OFF', server_extractorStatus);
      print("Extractor Apagado");
      return true;
    }
        if (moduleName == 'Scale' && moduleStatus == true) {
      mqttManager.publishMessage('ON', server_weightStatus);
      print("Báscula Encendida");
      return false;
    }
    if (moduleName == 'Scale' && moduleStatus == false) {
      mqttManager.publishMessage('OFF', server_weightStatus);
      print("Báscula Apagada");
      return true;
    }
  
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
      'Stove': (value) => Text(
            'Temperature: $value °C',
            style: const TextStyle(
                fontSize: 15.0, color: Color.fromRGBO(217, 217, 217, 1.0)),
          ),
      'Scale': (value) => Text(
            'Weight: $value gr.',
            style: const TextStyle(
                fontSize: 15.0, color: Color.fromRGBO(217, 217, 217, 1.0)),
          ),
      'Smoke Detector': (value) => Text(
            'Smoke detected: $value',
            style: const TextStyle(
                fontSize: 15.0, color: Color.fromRGBO(217, 217, 217, 1.0)),
          ),
    };

    final style = moduleValue[moduleName];

    return style != null ? style(value) : const Text('');
  }
}
