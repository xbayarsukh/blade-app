// ignore_for_file: unused_element

import 'dart:async';
import 'package:blade/configs/app_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import 'globals.dart';
// import 'package:get/get.dart';
// import 'globals.dart';

class ConfigNotification {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  late AndroidNotificationChannel _channel;
  bool _isFlutterLocalNotificationsInitialized = false;

  Future<void> initialize() async {
    await _requestPermission();
    await _setupFlutterNotifications();
    await _subscribeToTopic("all");
    await _handleInitialMessage();
    _setupForegroundMessageHandler();
  }

  Future<void> _requestPermission() async {
    await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      sound: true,
    );

    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> _setupFlutterNotifications() async {
    if (_isFlutterLocalNotificationsInitialized) return;

    _channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);

    _isFlutterLocalNotificationsInitialized = true;
    if (!AppDatabase().isLoggedIn()) {
      deviceId = await _messaging.getToken() ?? '';
      Get.log('token: $deviceId');
    }
  }

  Future<void> _subscribeToTopic(String topic) async {
    await _messaging.subscribeToTopic(topic);
  }

  Future<void> _handleInitialMessage() async {
    final message = await _messaging.getInitialMessage();
    if (message != null) {
      // Handle the message when the app is opened from a terminated state
    }
  }

  void _setupForegroundMessageHandler() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _showFlutterNotification(message);
    });
  }

  void _showFlutterNotification(RemoteMessage message) {
    final notification = message.notification;

    if (notification != null && !kIsWeb) {
      _flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _channel.id,
            _channel.name,
            channelDescription: _channel.description,
            icon: 'ic_launcher',
          ),
        ),
      );
    }
  }
}
