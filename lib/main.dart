import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:notification_demo/try/notification_try.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initNotificationServicesInBackground();
  runApp(const MyApp());
}

initNotificationServicesInBackground() async {
  var service = FlutterBackgroundService();
  if (Platform.isIOS) {
    await FlutterLocalNotificationsPlugin().initialize(
        const InitializationSettings(iOS: DarwinInitializationSettings()));
  }
  await FlutterLocalNotificationsPlugin()
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(const AndroidNotificationChannel(
        "android notification",
        "android notification name",
        description: "android notification description",
        importance: Importance.high,
      ));

  //init service and start
  await service.configure(
      iosConfiguration: IosConfiguration(
        onForeground: onStart,
        onBackground: iosBackground,
      ),
      androidConfiguration: AndroidConfiguration(
          onStart: onStart,
          isForegroundMode: true,
          notificationChannelId: "android notification",
          initialNotificationTitle: "android notification name",
          initialNotificationContent: "android notification description",
          foregroundServiceNotificationId: 90));

  await service.startService();
}

//onStart method.
@pragma("vm:entry-point")
void onStart(ServiceInstance service) async {
  var index = 0;
  DartPluginRegistrant.ensureInitialized();
  service.on("setAsForeground").listen((event) {
    debugPrint("running in foreground $event");
  });
  service.on("setAsBackground").listen((event) {
    debugPrint(
      "running in background $event",
    );
  });
  service.on("stopService").listen((event) {
    service.stopSelf();
  });
  Timer.periodic(const Duration(seconds: 5), (timer) async {
    print("running once $index ");
    index = index + 1;

    var lat;
    var apiUrl = 'https://jsonplaceholder.typicode.com/posts/$index';
    final response = await http.get(Uri.parse(apiUrl));
    final data = json.decode(response.body);
    print(data);
    await Geolocator.getCurrentPosition().then((value) {
      print(value);
      lat = value.latitude;
    });
    await FlutterLocalNotificationsPlugin().show(
      1,
      "you are in $lat and ${DateTime.now()}, ",
      "${DateTime.now().toIso8601String()}data is $data",
      const NotificationDetails(
          android: AndroidNotificationDetails(
              "android notification", "android notification name",
              icon: "app_icon", ongoing: true)),
    );
  });
}

Future<bool> iosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  return true;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const NotificationTry(),
    );
  }
}
