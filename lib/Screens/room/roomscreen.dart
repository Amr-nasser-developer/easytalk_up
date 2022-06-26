import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart'
    show
        BuildContext,

        Key,
        State,
        StatefulWidget,
        TextEditingController,
        Widget;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translationchat/Screens/chat/chat_screen_copy.dart';
import 'package:translationchat/Screens/room/room_body.dart';
import 'package:translationchat/models/roommodel.dart';
import 'package:translationchat/provider/chatprovider.dart';
import 'package:translationchat/provider/userprovider.dart';
import 'package:translationchat/shared/components/navigator.dart';
import 'package:translationchat/shared/utils/firebase_messaging.dart';



class RoomScreen extends StatefulWidget  {
  const RoomScreen({Key? key}) : super(key: key);
  @override
  RoomScreenState createState() => RoomScreenState();
}

class RoomScreenState extends State<RoomScreen> with WidgetsBindingObserver {
  // const _SignUpState({Key? key}) : super(key: key);const MyHomePage({Key? key, required this.title}) : super(key: key);

  late final TextEditingController controller = TextEditingController();

 Future<void>  setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    final validationService = Provider.of<ChatProvider>(context, listen: false);
    final validationService2 = Provider.of<UserProvider>(context,listen: false);

    await FirebaseMessaging.instance.getInitialMessage();
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {

          RoomModel roomModel = RoomModel(favoriteId: 0,isActive:int.parse( message.data["user2_is_active"].toString()),
     updatedAt: message.data["user2_updated_at"],
     imageUrl: "", user2Id:message.data["user2_id"], chatId: "",
      lastMessageTime: "", name: message.data["user2_name"], email: "",
    lastMessage: "",
     mobileNumber: "", fireBaseChatId: message.data["firebase_chat_id"]);

        AppNavigator.navigateTo(context, ChatScreen(
            roomBool: true,
            roomModel:
            roomModel,
            user1: validationService2.
            listUserProfileGeneralState.data!.idModify));
      });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
       validationService.getChats();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    print("dispose");
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }



  void didChangeAppLifecycleState(AppLifecycleState state)   async {
    final validationService2 = Provider.of<UserProvider>(context,listen: false);

    switch (state) {
      case AppLifecycleState.resumed:
        print("offline");
await validationService2.userIsOLine();
        break;
      case AppLifecycleState.inactive:
        print("offline");
        await      validationService2.userIsOLine();
        break;
      case AppLifecycleState.paused:
        print("online");
        await     validationService2.userIsOffLine();
        break;
      case AppLifecycleState.detached:
        print("dectected");
        await   validationService2.userIsOffLine();
       break;

    }
  }
@override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
  super.didChangeDependencies();
  }

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    init();
  }
  init() async {
    final validationService = Provider.of<ChatProvider>(context, listen: false);
    validationService.getChats();
     setupInteractedMessage();
    validationService.getFav();
    validationService.getActives();

  }
  @override
  Widget build(BuildContext context) {
 return RoomBody();

  }
}
