import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class NotificationTry extends StatefulWidget {
  const NotificationTry({super.key});

  @override
  State<NotificationTry> createState() => _NotificationTryState();
}

class _NotificationTryState extends State<NotificationTry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              //currently i am using this for permission purpose only
              await Geolocator.requestPermission();
              await Geolocator.getCurrentPosition().then((value) {
                print(value);
              });
            },
            child: const Text("Press me "),
          )
        ],
      ),
    );
  }
}
