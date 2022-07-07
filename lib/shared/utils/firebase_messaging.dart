import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FirebaseMessage {
  var dateTime = DateTime.now();
  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async
  {

    await Firebase.initializeApp();
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
    print('on background message');
    print(message.data.length);
    AppleNotificationSetting.enabled;
    AwesomeNotifications().createNotificationFromJsonData(message.data);
    AwesomeNotifications().initialize(
        'resource://drawable/res_app_icon',
        [
          NotificationChannel(
            channelGroupKey: 'basic_test',
            channelKey: 'basic',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            channelShowBadge: true,
          ),
        ]
    );
  }

  static Future<void>  setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.

    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
    print('User granted permission: ${settings.authorizationStatus}');
    if (initialMessage != null) {

    }
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message){
      print("message data");
      print("on background1");
      print(message.data);
    });

  }
}
