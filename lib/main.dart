import 'package:flutter/material.dart';
import 'package:notification_demo/services/init_notification_services.dart';
import 'package:notification_demo/try/notification_try.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initNotificationServicesInBackground();
  runApp(const MyApp());
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
