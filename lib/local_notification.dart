import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {
  // notification channel
  static final AndroidNotificationChannel channel = AndroidNotificationChannel(
    "Ba_APP_CHANNEL",
    "Ba_APP_CHANNEL_NOTIFICATION",
    importance: Importance.high,
    playSound: true,
  );

  // notification plugin object
  static final FlutterLocalNotificationsPlugin localNotifications =
      FlutterLocalNotificationsPlugin();

  // notification icon
  static final initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  // Initialization Settings for iOS devices
  static final IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings(
    requestSoundPermission: true,
    requestBadgePermission: true,
    requestAlertPermission: true,
  );

  // Initialization setting
  static final InitializationSettings initializationSettings =
      InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
    macOS: null,
    linux: null,
  );

  // init notification show
  static Future initNotificationShow(String? message) async {
    if (message != null) {
      var notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          color: Colors.transparent,
          playSound: true,
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
          icon: '@mipmap/ic_launcher',

        ),
        iOS: IOSNotificationDetails(),
      );
      Random random = Random();
      int id = random.nextInt(9999999) + 9999999;
      localNotifications.show(
        id,
        "notification.title",
        message,
        notificationDetails,
        payload: message,
      );
    }
  }

  // init local notification
  static Future init() async {
    await localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestPermission();
    await localNotifications.initialize(initializationSettings,
        onSelectNotification: (dynamic payload) async {
      if (payload != '') {}
    });
  }

  // local notification show
  static Future showNotification() async {
    int id = 0;
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      id.toString(),
      'notification' + id.toString(),
      channelDescription: channel.description,
      playSound: true,
      color: Colors.transparent,
      importance: Importance.max,
      priority: Priority.high,
          ongoing: true,
          autoCancel: false,
          onlyAlertOnce: true,
      icon: '@mipmap/ic_launcher',
    );
    var notificationDetails = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: IOSNotificationDetails(),
    );
    await localNotifications.show( id,
      "Running",
      "background task running",
      notificationDetails,
      payload: "onGoing",);
  }
}
