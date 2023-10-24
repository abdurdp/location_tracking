import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:workmanager/workmanager.dart';

import 'local_notification.dart';
import 'splash_screen.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    // Simulate an API request
    try {
      await Future.delayed(Duration(seconds: 30));
      LocalNotification.initNotificationShow("ApiCall Done");
    } catch (err) {
      debugPrint(err.toString());
      LocalNotification.initNotificationShow("ApiCall failed");
    }
    return Future.value(true);
  });
}

Future<void> cancelNotification(int notificationId) async {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin.cancel(notificationId);
}

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotification.init();
  runApp(MyApp());
  Workmanager().initialize(callbackDispatcher);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Location App',
      home: SplashScreen(),
    );
  }
}
