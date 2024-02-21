import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:notification_demo/main.dart';

class NotificationController {
  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    try {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        // print('Running on ${androidInfo.model}');
        // print('Serial number is  ${androidInfo.serialNumber}');
        //TODO: (INFO)- Serial numeber can be trickey to get, it may not be available on all devices. it responds unknown in some devices.

        // print('Running on ${androidInfo.device}');
        // print('Manufacturer is  ${androidInfo.manufacturer}');
        // print('android id is  ${androidInfo.id}');
      }
      // To send the information about the notification dismissed to the server we can simply create the post method
      // and send the information to the server like androidInfo.model, androidInfo.serialNumber, androidInfo.device, androidInfo.manufacturer, androidInfo.id etc.
    } catch (error) {
      Exception(error.toString());
    }
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    try {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        //TODO: create function and send data to the server.
      }
    } catch (error) {
      Exception(error.toString());
    }
    // Navigate into pages, avoiding to open the notification details page over another details page already opened
    if (receivedAction.buttonKeyPressed == "markAsRead") {
      MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
          '/', (route) => (route.settings.name != '/') || route.isFirst,
          arguments: receivedAction);
    } else {
      MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
          '/notification-page',
          (route) =>
              (route.settings.name != '/notification-page') || route.isFirst,
          arguments: receivedAction);
    }
  }
}
