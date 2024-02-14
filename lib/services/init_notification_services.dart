import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:notification_demo/services/retrive_data.services.dart';

initNotificationServicesInBackground() async {
  var service = FlutterBackgroundService();
  if (Platform.isAndroid) {
    await service.configure(
      iosConfiguration: IosConfiguration(
        onForeground: onStart,
        onBackground: iosBackground,
      ),
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        isForegroundMode: true,
      ),
    );
  }
  AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      //currently we are using default icon
      null,
      [
        NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: const Color(0xFF9D50DD),
            ledColor: Colors.white)
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'basic_channel_group',
            channelGroupName: 'Basic group')
      ],
      debug: true);

  service.startService();
}

//onStart method
// pragma is used for the entry point of the application
@pragma("vm : entry-point")
void onStart(ServiceInstance service) async {
  String? title;
  String? body;
  service.on("setAsForeground").listen((event) {
    print("service on foreground  ${event?.entries}");
  });
  service.on("setAsBackground").listen((event) {
    print("service on foreground  ${event?.entries}");
  });
  service.on("stopService").listen((event) {
    service.stopSelf();
  });

  Timer.periodic(const Duration(minutes: 20), (timer) async {
    var response = await RetrieveDataFromServer().getServerData();
    if (response != null) {
      title = response.title;
      body = response.body;
    }
    response != null
        ? await AwesomeNotifications().createNotification(
            actionButtons: [
              NotificationActionButton(
                key: 'markAsRead',
                label: 'Mark as read',
                autoDismissible: true,
              ),
              NotificationActionButton(
                key: 'shop now ',
                label: 'shop now ',
                autoDismissible: true,
              ),
            ],
            content: NotificationContent(
              criticalAlert: true,
              actionType: ActionType.DismissAction,
              backgroundColor: Colors.deepPurple,
              notificationLayout: NotificationLayout.BigText,
              summary: "this is summery ",
              id: Random().nextInt(max(100, 1000)),
              channelKey: 'basic_channel',
              title: '$title',
              body: 'data is $title ${body ?? "null"}',
              payload: ({
                "title": "This is the title",
                "body": "This is the body",
                "location": "This is the lat lng",
              }),
            ),
          )
        : null;
  });
}

Future<bool> iosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  return true;
}
