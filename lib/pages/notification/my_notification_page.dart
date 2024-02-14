import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class MyNotificationPage extends StatelessWidget {
  final ReceivedAction receivedAction;
  const MyNotificationPage({super.key, required this.receivedAction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
            "This is Notification page with action: ${receivedAction.actionDate} and ${receivedAction.payload}"),
      ),
    );
  }
}
