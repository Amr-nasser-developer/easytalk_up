import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessage {

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
