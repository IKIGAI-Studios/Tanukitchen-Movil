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
enum MqttSubscriptionState {
IDLE,
SUBSCRIBED
}


class MQTTManager {

  double stoveValue = 0.0;

  MqttServerClient client;


  MqttCurrentConnectionState connectionState = MqttCurrentConnectionState.IDLE;
  MqttSubscriptionState subscriptionState = MqttSubscriptionState.IDLE;

  MQTTManager()
      : client = MqttServerClient.withPort(MIKE_CLUSTER_URL, MIKE_USERNAME, MQTT_PORT) {
    client.secure = true;
    client.securityContext = SecurityContext.defaultContext;
    client.keepAlivePeriod = 20;
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
      var message = double.parse(MqttPublishPayload.bytesToStringAsString(recMess.payload.message));


          if (topicName == client_stove) {
      stoveValue = message;
      
    } 

      print('YOU GOT A NEW MESSAGE:');
      print(message);
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
