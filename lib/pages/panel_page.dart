import 'package:tanukitchen/mqtt/mqtt_manager.dart';
import 'package:tanukitchen/models/user_model.dart';
import 'package:tanukitchen/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:tanukitchen/mqtt/mqtt_routes.dart';

class PanelPage extends StatefulWidget {
  final User user;
  const PanelPage({Key? key, required this.user}) : super(key: key);

  @override
  State<PanelPage> createState() => _PanelPageState();
}

class _PanelPageState extends State<PanelPage> {

  final MQTTManager _mqttManager = MQTTManager(); 
   
   
  @override
  void initState() {
    super.initState();
    _setupMqtt();
}


  @override
  void dispose() {
    _mqttManager.client.disconnect();
    super.dispose();
  }


  void _setupMqtt() async {

    try {
      await _mqttManager.connect();
      _mqttManager.subscribeToTopic(client_stove);
      _mqttManager.subscribeToTopic(client_weight);
      _mqttManager.subscribeToTopic(client_smoke);
      
    _mqttManager.client.updates?.listen((_) {
      setState(() {
        _mqttManager.stoveValue;// Actualizar el valor del atributo
      });
      });
    } catch (e) {
      print('Error al configurar MQTT: $e');
    }

      }
  

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: const Color.fromRGBO(39, 47, 63, 1.0),
              title: const Text(
                'tanukitchen',
                style: TextStyle(
                    fontFamily: 'Somatic',
                    color: Color.fromRGBO(217, 217, 217, 1.0)),
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => MyProfile(
                          user: widget.user,
                        ),
                      ),
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
                            'assets/images/pfp.png',
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
                  Text('Stove Value: ${_mqttManager.stoveValue.toStringAsFixed(2)}'),
                  
              ],
            ),
          );
        }
      }
