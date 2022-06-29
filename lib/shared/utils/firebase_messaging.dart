import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessage {
  var dateTime = DateTime.now();
  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async
  {
    await Firebase.initializeApp();
    print('on background message');
    print(message.data.length);
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

    if (initialMessage != null) {

    }
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message){
      print("message data");
      print("on background1");
      print(message.data);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("message data");
print("on background");
print(message.data);
    });
  }
}
