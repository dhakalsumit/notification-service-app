
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await initNotificationServicesInBackground();
//   runApp(const MyApp());
// }

// initNotificationServicesInBackground() async {
//   var service = FlutterBackgroundService();
//   // if (Platform.isIOS) {
//   //   await FlutterLocalNotificationsPlugin().initialize(
//   //       const InitializationSettings(iOS: DarwinInitializationSettings()));
//   // }
//   // await FlutterLocalNotificationsPlugin()
//   //     .resolvePlatformSpecificImplementation<
//   //         AndroidFlutterLocalNotificationsPlugin>()
//   //     ?.createNotificationChannel(const AndroidNotificationChannel(
//   //       "android notification",
//   //       "android notification name",
//   //       description: "android notification description",
//   //       importance: Importance.high,
//   //     ));

//   //awesome notification
//   AwesomeNotifications().initialize(
//       // set the icon to null if you want to use the default app icon
//       null,
//       [
//         NotificationChannel(
//             channelGroupKey: 'basic_channel_group',
//             channelKey: 'basic_channel',
//             channelName: 'Basic notifications',
//             channelDescription: 'Notification channel for basic tests',
//             defaultColor: const Color(0xFF9D50DD),
//             ledColor: Colors.white)
//       ],
//       // Channel groups are only visual and are not required
//       channelGroups: [
//         NotificationChannelGroup(
//             channelGroupKey: 'basic_channel_group',
//             channelGroupName: 'Basic group')
//       ],
//       debug: true);
//   //init service and start
//   await service.configure(
//       iosConfiguration: IosConfiguration(
//         onForeground: onStart,
//         onBackground: iosBackground,
//       ),
//       androidConfiguration: AndroidConfiguration(
//           onStart: onStart,
//           isForegroundMode: true,
//           notificationChannelId: "android notification",
//           initialNotificationTitle: "android notification name",
//           initialNotificationContent: "android notification description",
//           foregroundServiceNotificationId: 90));

//   await service.startService();
  
// }

// //onStart method.
// @pragma("vm:entry-point")
// void onStart(ServiceInstance service) async {
//   var index = 0;

//   service.on("setAsForeground").listen((event) {
//     debugPrint("running in foreground $event");
//   });
//   service.on("setAsBackground").listen((event) {
//     debugPrint(
//       "running in background $event",
//     );
//   });
//   service.on("stopService").listen((event) {
//     service.stopSelf();
//   });
//   Timer.periodic(const Duration(seconds: 10), (timer) async {
//     print("running once $index ");
//     index = index + 1;

//     var lat;
//     var apiUrl = 'https://jsonplaceholder.typicode.com/posts/$index';
//     final response = await http.get(Uri.parse(apiUrl));
//     final data = json.decode(response.body);
//     print(data);
//     await Geolocator.getCurrentPosition().then((value) {
//       print(value);
//       lat = value.latitude;
//     });

//     await AwesomeNotifications().createNotification(
//       actionButtons: [
//         NotificationActionButton(
//           key: 'markAsRead',
//           label: 'Mark as read',
//           autoDismissible: true,
//         ),
//         NotificationActionButton(
//           key: 'shop now ',
//           label: 'shop now ',
//           autoDismissible: false,
//         ),
//       ],
//       content: NotificationContent(
//         actionType: ActionType.DismissAction,
//         backgroundColor: Colors.deepPurple,
//         notificationLayout: NotificationLayout.BigPicture,
//         id: index,
//         channelKey: 'basic_channel',
//         title: 'you are in $lat and ${DateTime.now()}',
//         body: 'data is $data',
//         payload: ({
//           "data": "data is $data",
//         }),
//       ),
//     );
//     // await FlutterLocalNotificationsPlugin().show(
//     //   1,
//     //   "you are in $lat and ${DateTime.now()}, ",
//     //   "${DateTime.now().toIso8601String()}data is $data",
//     //   const NotificationDetails(
//     //       android: AndroidNotificationDetails(
//     //     "android notification",
//     //     "android notification name",
//     //     icon: "app_icon",
//     //     ongoing: true,
//     //     importance: Importance.high,
//     //   )),
//     //   payload: ({'index': index, 'lat': lat, 'data': data}).toString(),
//     // );
//   });
// }

// Future<bool> iosBackground(ServiceInstance service) async {
//   WidgetsFlutterBinding.ensureInitialized();
//   return true;
// }