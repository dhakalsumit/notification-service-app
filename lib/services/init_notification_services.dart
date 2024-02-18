import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notification_demo/services/retrive_data.services.dart';

initNotificationServicesInBackground() async {
  // running application in the background.
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
  //to create the notification and display to the user.
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
  service.on("setAsForeground").listen((event) {});
  service.on("setAsBackground").listen((event) {});
  service.on("stopService").listen((event) {
    service.stopSelf();
  });

  Timer.periodic(const Duration(seconds: 20), (timer) async {
    Hive.initFlutter();
    var response = await RetrieveDataFromServer().getServerData();
    if (response != null) {
      if (response.isNotEmpty) {
        for (var i = 0; i < response.length; i++) {
          await AwesomeNotifications().createNotification(
            actionButtons: [
              NotificationActionButton(
                key: 'markAsRead',
                label: 'open app',
                autoDismissible: true,
              ),
              NotificationActionButton(
                key: 'shop now ',
                label: 'view details',
                autoDismissible: true,
              ),
            ],
            content: NotificationContent(
              criticalAlert: true,
              fullScreenIntent: true,

              //This picture is displayed in the notification bar
              bigPicture:
                  // "https://thumbs.dreamstime.com/b/grunge-not-found-framed-rounded-rectangle-stamp-not-found-stamp-seal-watermark-grunge-style-seal-shape-rounded-rectangle-134959326.jpg",
                  "${Hive.box("ip")}/media/productImages/Apple-MacBook-Air-M1-13-1.png",
              actionType: ActionType.Default,
              backgroundColor: Colors.deepPurple,
              notificationLayout: NotificationLayout.BigPicture,
              summary: "${response[i].shopName}",
              id: Random().nextInt(max(100, 1000)),
              channelKey: 'basic_channel',
              title: "${response[i].productName}",
              body:
                  "${response[i].productName} available at ${response[i].shopName} at ${response[i].offerPrice} only. Hurry up! Limited stock available.",
              payload: ({
                'id': response[i].id.toString(),
                'productName': response[i].productName,
                'productDescription': response[i].productDescription,
                'offerPrice': response[i].offerPrice.toString(),
                'originalPrice': response[i].originalPrice.toString(),
                'productImage': response[i].productImage,
                'shopName': response[i].shopName,
              }),
            ),
          );
        }
      }
    }
    // : null;
  });
}

Future<bool> iosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  return true;
}
