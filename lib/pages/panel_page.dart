import 'package:tanukitchen/models/module_model.dart';
import 'package:tanukitchen/mqtt/mqtt_manager.dart';
import 'package:tanukitchen/models/user_model.dart';
import 'package:tanukitchen/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:tanukitchen/db/mongodb.dart';
import 'package:tanukitchen/mqtt/mqtt_routes.dart';
import 'package:tanukitchen/widgets/module_card_widget.dart';

class PanelPage extends StatefulWidget {
  final User user;
  const PanelPage({Key? key, required this.user}) : super(key: key);

  @override
  State<PanelPage> createState() => _PanelPageState();
}

class _PanelPageState extends State<PanelPage> {
  final MQTTManager _mqttManager = MQTTManager();
  double _stoveValue = 0.0;
  double _weightValue = 0.0;
  double _extractorValue = 0.0;
  bool _stoveStatus = false;
  bool _weightStatus = false;

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
      _mqttManager.subscribeToTopic(client_stoveValue);
      _mqttManager.client.updates?.listen((_) {
        setState(() {
          _stoveValue = _mqttManager.stoveValue;
        });
      });

      _mqttManager.subscribeToTopic(client_weightValue);
      _mqttManager.client.updates?.listen((_) {
        setState(() {
          _weightValue = _mqttManager.weightValue;
        });
      });

      _mqttManager.subscribeToTopic(client_extractorValue);
      _mqttManager.client.updates?.listen((_) {
        setState(() {
          _extractorValue = _mqttManager.extractorValue;
        });
      });

      _mqttManager.subscribeToTopic(client_stoveStatus);
      _mqttManager.client.updates?.listen((_) {
        setState(() {
          if (_mqttManager.stoveStatus == 'On') {
            _stoveStatus = true;
          }
        });
      });

      _mqttManager.subscribeToTopic(client_weightStatus);
      _mqttManager.client.updates?.listen((_) {
        setState(() {
          if (_mqttManager.weightStatus == 'On') {
            _weightStatus = true;
          }
        });
      });
    } catch (e) {
      print('Error al configurar MQTT: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double currentStoveValue = _stoveValue;
bool currentStoveStatus = _stoveStatus;
double currentWeightValue = _weightValue;
bool currentWeightStatus = _weightStatus;
double currentExtractorValue = _extractorValue;

    return FutureBuilder(
        future: MongoDB.getModules(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // CIRCULITO QUE DA VUELTAS XD
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
            );
          }
          // TAKITO MAN
          else if (snapshot.hasError) {
            return Column(children: [
              Image.asset('assets/images/TakumiSeatedBlue.png'),
              const Text('Lo sentimos, ocurrió un error. Inténtalo más tarde.'),
            ]);
          } else {
            // SI  SALE BIEN: SÍ SCAFOL

            return Scaffold(
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
                  ModuleCard(
                    module: Module.fromMap(snapshot.data[0]),
                    value: currentStoveValue,
                    status: currentStoveStatus,
                  ),
                  ModuleCard(
                    module: Module.fromMap(snapshot.data[2]),
                    value: currentExtractorValue,
                  ),
                  ModuleCard(
                    module: Module.fromMap(snapshot.data[3]),
                    value: currentWeightValue,
                    status: currentWeightStatus,
                  ),
                ],
              ),
            );
          }
        });
  }
}
