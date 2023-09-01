import 'dart:io';

import 'package:tanukitchen/utilities/consts.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import 'package:tanukitchen/mqtt/mqtt_routes.dart';

enum MqttCurrentConnectionState {
  IDLE,
  CONNECTING,
  CONNECTED,
  DISCONNECTED,
  ERROR_WHEN_CONNECTING
}

enum MqttSubscriptionState { IDLE, SUBSCRIBED }

class MQTTManager {
  double stoveValue = 0.0;
  double weightValue = 0.0;
  double extractorValue = 0.0;
  double smokeValue = 0.0;
  String stoveStatus = '';
  String weightStatus = '';
  String extractorStatus = '';

  MqttServerClient client;

  MqttCurrentConnectionState connectionState = MqttCurrentConnectionState.IDLE;
  MqttSubscriptionState subscriptionState = MqttSubscriptionState.IDLE;

  MQTTManager()
      : client = MqttServerClient.withPort(
            MIKE_CLUSTER_URL, MIKE_USERNAME, MQTT_PORT) {
    client.secure = true;
    client.securityContext = SecurityContext.defaultContext;
    client.keepAlivePeriod = 60;
    client.onDisconnected = _onDisconnected;
    client.onConnected = _onConnected;
    client.onSubscribed = _onSubscribed;
  }

  Future<void> connect() async {
    try {
      print('client connecting....');
      await client.connect(MIKE_USERNAME, MIKE_PASSWORD);
    } on Exception catch (e) {
      print('client exception - $e');
      client.disconnect();
    }

    if (client.connectionStatus?.state == MqttConnectionState.connected) {
      connectionState = MqttCurrentConnectionState.CONNECTED;
      print('client connected');
    } else {
      print(
          'ERROR client connection failed - disconnecting, status is ${client.connectionStatus}');
      connectionState = MqttCurrentConnectionState.ERROR_WHEN_CONNECTING;
      client.disconnect();
    }
  }

  void subscribeToTopic(String topicName) {
    print('Subscribing to the $topicName topic');
    client.subscribe(topicName, MqttQos.atMostOnce);

    client.updates?.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
      var message =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

      if (c[0].topic == client_stoveValue) {
        print('Valor de la temperatura: ');
        print(message);
        stoveValue = double.parse(message);
      }
      if (c[0].topic == client_weightValue) {
        print('Valor de la scale: ');
        print(message);
        weightValue = double.parse(message);
      }
      if (c[0].topic == client_smokeValue) {
        print('Valor del detector de humo: ');
        print(message);
        smokeValue = double.parse(message);
      }
      if (c[0].topic == client_stoveStatus) {
        print('Estado de la estufa: ');
        print(message);
        stoveStatus = message;
      }
      if (c[0].topic == client_weightStatus) {
        print('Estado de la báscula: ');
        print(message);
        weightStatus = message;
      }
      if (c[0].topic == client_extractorStatus) {
        print('Estado del extractor: ');
        print(message);
        extractorStatus = message;
      }
    });
  }

  void publishMessage(String message, String topic) {
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    builder.addString(message);

    print('Publishing message "$message" to topic $topic');
    client.publishMessage(topic, MqttQos.exactlyOnce, builder.payload!);
  }

  void _onSubscribed(String topic) {
    print('Subscription confirmed for topic $topic');
  }

  void _onDisconnected() {
    print('OnDisconnected client callback - Client disconnection');
  }

  void _onConnected() {
    print('OnConnected client callback - Client connection was successful');
  }
}
