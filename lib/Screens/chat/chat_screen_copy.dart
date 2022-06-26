import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart' show BuildContext, Center, Column, CupertinoSwitch, EdgeInsets, Key,  TextEditingController, Widget;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:provider/provider.dart';
import 'package:translationchat/Screens/room/roomscreen.dart';
import 'package:translationchat/constants/colors.dart';
import 'package:translationchat/constants/images.dart';
import 'package:translationchat/constants/strring.dart';
import 'package:translationchat/models/messagemodel.dart';
import 'package:translationchat/models/roommodel.dart';
import 'package:translationchat/provider/chatprovider.dart';
import 'package:translationchat/provider/userprovider.dart';
import 'package:translationchat/shared/components/bottomsheetglobal.dart';
import 'package:translationchat/shared/components/progress.dart';
import 'package:translationchat/shared/components/sizedboxglobal.dart';
import 'package:translationchat/shared/components/textfieldglobal.dart';


import 'package:translationchat/shared/text_global.dart';
import 'package:translationchat/shared/utils/time_ago.dart';
import 'package:translationchat/shared/widgets/circleavatatimage.dart';

import '../../shared/components/buttonglobal.dart';
import 'components/message.dart';
final  FocusNode  focusNode = FocusNode();
final TextEditingController controller = TextEditingController();
class ChatScreen extends StatefulWidget {
  RoomModel? roomModel;
  int user1;
  bool roomBool;

  ChatScreen({Key? key,this.roomModel,required this.user1,required this.roomBool}) : super(key: key);
  @override
  ChatScreenState createState() => ChatScreenState ();
}

class ChatScreenState extends State<ChatScreen> with WidgetsBindingObserver{
  // const _SignUpState({Key? key}) : super(key: key);const MyHomePage({Key? key, required this.title}) : super(key: key);


  ScrollController ? _controller;
  String? x;


  //bool emojiShowing = false;
//  bool isKeyboardVisible = false;

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

        await validationService2.userIsOLine();
        break;
      case AppLifecycleState.inactive:

        await      validationService2.userIsOLine();
        break;
      case AppLifecycleState.paused:

        await     validationService2.userIsOffLine();
        break;
      case AppLifecycleState.detached:

        await   validationService2.userIsOffLine();
        break;

    }
  }

  on(BuildContext context) {
    final validationService = Provider.of<ChatProvider>(context, listen: false);
    validationService.getChats();
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    // TODO: implement initState
   // WidgetsBinding.instance!.addObserver(this);
    super.initState();
    init();
  }
  init() async {
    final validationService = Provider.of<ChatProvider>(context, listen: false);
 await  validationService.getLangauge();

  }


  Future toggleEmojiKeyboard(BuildContext context) async {
    final validationService = Provider.of<ChatProvider>(context, listen: false);
    if (validationService.isKeyboardVisible) {
      FocusScope.of(context).unfocus();
    }

    validationService.emojShowingBoolean();
  }



  @override
  Widget build(BuildContext context) {
    final validationService = Provider.of<ChatProvider>(context, listen: false);

    final validationService2 = Provider.of<UserProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        if (validationService.emojiShowing == false) {
     
          validationService.emojShowingBoolean();
          return true;
        } else {
          //print(validationService.emojiShowing);
          var data = await
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => RoomScreen(),), (route) => false);
      return data;
        }
        // return  validationService.getChats();


      },
      child: SafeArea(
        child: Scaffold(
            backgroundColor: cyan,
            body:
            GestureDetector(
              onTap: (){
          focusNode.unfocus();
          final validationService = Provider.of<ChatProvider>(context, listen: false);
          validationService.emojShowingfalse();
              },
              child: Center(
                  child: Container(

                    height: MediaQuery
                        .of(context)
                        .size
                        .height,
                    color: cyan,
                    child: Column(children: [
                      sizedBoxGlobalHeight10(),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(onTap: () async {
                              var data = await
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => RoomScreen(),), (route) => false);
                              return data;
                            }, child: const Icon(Icons.arrow_back_ios,
                              color: Colors.white,)),
                              Consumer<ChatProvider>(
    builder: (context, provider, child)
    {
    return                      CupertinoSwitch(
                              trackColor: Colors.white,
                              activeColor: yellow,
                              value: validationService.settingLang,
                              onChanged: (value) {
                         print(validationService.settingLang);
                                validationService.changeLang();
                              },
                            );}),


                          ],),
                      ),
                      sizedBoxGlobalHeight10(),

                      Expanded(child: Container(decoration: BoxDecoration(
                          //color: const Color(0xff7c94b6),
                          image:  DecorationImage(

                            //  fit: BoxFit.cover,
                              colorFilter: new ColorFilter.mode(Colors.white.withOpacity(0.1), BlendMode.dstATop),
                            image:  ExactAssetImage(logo),
                          ),

                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0)),

                        color: Colors.white,
                      ),
                        child: Column(children: [
                          sizedBoxGlobalHeight10(),
                        Row(mainAxisAlignment: MainAxisAlignment.center,children: [

                          textGlobalDarkCyanBold16(context: context,
                              text:widget.roomModel!.name),
                          SizedBox(width: 5,),
                          circleAvatarImage(widget.roomModel!.imageUrl, false),

                        ],),
                                             widget.roomModel!.isActive==0?
                          textGlobalDarkCyanBold13(context: context,text: " نشط ${widget.roomModel!.updatedAt} "):textGlobalDarkCyanBold13(context: context,text: "نشط الان"),
    Consumer<ChatProvider>(
    builder: (context, provider, child)
    {
    if(validationService.settingLang==true){
    return GestureDetector(
    onTap: () {
    bottomSheetGlobal(context: context,
    user1:widget. user1,
    chatId:widget. roomModel!.fireBaseChatId);
    }
    , child: Directionality(
    textDirection: TextDirection.rtl,
    child: Center(
    child: Container(
    width: 200,

    padding: const EdgeInsets.only(left: 12.0),
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(15.0),
    color: lightCyan,
    ),
    child: Row(mainAxisAlignment: MainAxisAlignment
        .spaceBetween, children: [
    sizedBoxGlobalWidth20(),
    const Icon(Icons.keyboard_arrow_down,
    color: Colors.white,),

    StreamBuilder<DocumentSnapshot>(
    stream: validationService.getLang(
 widget.   roomModel!.fireBaseChatId),
    builder: (BuildContext context,
    AsyncSnapshot<
    DocumentSnapshot> snapshot) {
    validationService.getLangList(snapshot,widget. user1);
    return Expanded(child:  textGlobalWhiteNormal14(
    context: context,
    text: validationService.user.lang
        .toString()));
    }),



    /*Consumer<ChatProvider>(
    builder: (context, provider, child) {


    return                            textGlobalWhiteNormal16(
                                      context: context, text: provider.chosenLangIndex.lang);
    })*/
    sizedBoxGlobalWidth20(),
    const Icon(Icons.map, color: Colors.white,),


    ],),),
    ),
    ),
    );
    }else{
    return SizedBox(height: 20);
    }

    }),



                          SizedBox(height: 20),
                          StreamBuilder<DocumentSnapshot>(
                              stream: validationService.getMessage(
                                 widget.roomModel!.fireBaseChatId),
                              builder: (BuildContext context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return Expanded(child: Container(color: Colors.white,child: progress()));
                                } //end
                                else if (snapshot.hasError) {
                                  return new Text("");
                                  // #to_do handling the progess bar to be stop if there no connecction
                                  // or error happened
                                }

                                else {
                                  if (snapshot.data != null) {
                                    validationService.printMessage(snapshot);

                                    return Expanded(child: ListView.builder(
                                       // shrinkWrap: true,

                                   //     physics: ScrollPhysics(),
                                       reverse: true,
                                        controller: _controller,
                                        padding: const EdgeInsets.all(5),
                                        itemCount: validationService.messageList
                                            .length,
                                        itemBuilder: (BuildContext context,
                                            int index) {
                                          return Padding(
                                            padding: EdgeInsets.all(5),

                                              child:



                                                    Column(  crossAxisAlignment:

                                                      validationService
                                                        .messageList[index].from
                                                        == widget.user1
                                                        ? CrossAxisAlignment.end : CrossAxisAlignment.start,children: [


                                                         MessageComponents(index: index,
                                                           checkMessage: true,
                                                           user1: widget.user1,),


                                                      validationService.messageList[index].type !="text"?
                                                      Row( mainAxisAlignment:
                                                             validationService.messageList[index].from == widget.user1
                                                                 ? MainAxisAlignment.end
                                                                 : MainAxisAlignment.start,children: [
                                                               textGlobalBlackNormal13(text:
                                                               TimeAgo.timeAgoSinceDate(validationService
                                                                   .messageList[index]
                                                                   .creationDt)
                                                                   , context: context)
                                                             ],):
                                                               Directionality(textDirection: validationService
                                              .messageList[index].from
                                          == widget.user1 ?TextDirection.rtl:TextDirection.ltr,child:            textGlobalBlackNormal13(text:
                                                               formatDate(validationService
                                                                   .messageList[index]
                                                                   .creationDt,[dd, '/', mm, '/', yyyy, ' ', HH, ':' , nn])
                                                          , context: context)),
                                                    ],)




                                          );
                                        }
                                    ),);
                                  } else {
                                    return Text("");
                                  }
                                }
                              }),



                          ActionButton(roomBool:widget. roomBool,
                            roomModel: widget.roomModel,
                            user1:widget.user1,),
                          EmojyPicker(),


                        ],),)),

                    ],),
                  )),
            )),
      ),
    );
  }





}









_onEmojiSelected(String emoji,BuildContext context) {

  controller.text = controller.text + emoji;
  //  validationService.emojShowingBoolean();
}




class EmojyPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final validationService = Provider.of<ChatProvider>(context,listen: false);
    return  Consumer<ChatProvider>(
        builder: (context, provider, child)
        {
          return Offstage(
            offstage: validationService.emojiShowing,
            child: SizedBox(
              height: 250,
              child: EmojiPicker(
                  onEmojiSelected: (Category category, Emoji emoji) {
                    _onEmojiSelected(emoji.emoji,context);
                  },
                  onBackspacePressed: (){
                    validationService.emojShowingBoolean();
                  },
                  config: Config(
                      columns: 7,
                      // Issue: https://github.com/flutter/flutter/issues/28894
                      emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                      verticalSpacing: 0,
                      horizontalSpacing: 0,
                      initCategory: Category.RECENT,
                      bgColor: const Color(0xFFF2F2F2),
                      indicatorColor: Colors.blue,
                      iconColor: Colors.grey,
                      iconColorSelected: Colors.blue,
                      progressIndicatorColor: Colors.blue,
                      backspaceColor: Colors.blue,
                      showRecentsTab: true,
                      recentsLimit: 28,
                      tabIndicatorAnimDuration: kTabScrollDuration,
                      categoryIcons: const CategoryIcons(),
                      buttonMode: ButtonMode.MATERIAL)),
            ),
          );
        });
  }
  }




class ActionButton extends StatelessWidget {

  RoomModel? roomModel;
  int user1;
  bool roomBool;
  ActionButton({Key? key,this.roomModel,required this.user1,required this.roomBool});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final validationService = Provider.of<ChatProvider>(context,listen: false);


    return  Consumer<ChatProvider>(
        builder: (context, provider, child)
        {
          return Padding(
            padding: const EdgeInsets.only(
                left: 20, right: 20, bottom: 10.0, top: 10.0),
            child: Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              decoration: BoxDecoration(
                color: darkCyan,
                borderRadius: const BorderRadius.all(Radius.circular(25)),
              ), child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(children: [

             InkWell(onTap: () async {


               bottomSheetGlobadl(context: context, body: CheckMap(user1: user1,documentId:roomModel!.fireBaseChatId ,to: roomModel!.user2Id,), height: 200.0);







             },child: Icon(Icons.add_location_alt,color: white,),),
                IconButton(onPressed: () {
                  focusNode.unfocus();

                 validationService.emojShowingBoolean();
                }, icon: Image.asset("assests/Iconfeather-smile.png", width: 20,)),


                Expanded(child: TextFieldGlobal2(myFocusNode: focusNode,keyboardType: TextInputType.text,controller: controller,
                  label: darkCyan,
                  hint: '',
                  widthBorder: 0.0,)),
                sizedBoxGlobalWidth10(),
                InkWell(onTap: (){
                  validationService.message= Message(type: 1.toString(), message: '',
                    from: user1,
                    to: int.parse(roomModel!.user2Id),
                    documentId:roomModel!.fireBaseChatId, creationDt: DateTime.now(), translateMessage: '');
                  bottomSheetGlobadl(context: context, body: addCamera(context: context, mainImage: true,sortUploadImage: false), height:200.0);
                },child:Icon(Icons.image, color: Colors.white,)),
                sizedBoxGlobalWidth10(),


                IconButton(onPressed: () async {
                  appl.message = controller.text;

                  controller.text = "";
                  validationService.listen();
                  print(validationService.messageList.length);
                  if (validationService.messageList.isNotEmpty) {
                    if (roomBool == true) {
                      appl.chatId = roomModel!.chatId;
                    }
                    String word = await validationService
                        .translateWord(
                        target: validationService
                            .anotherUser.code,
                        message: appl.message);
                    print(word);
                    validationService.addMessage(addOrUpdate: true,
                        text: appl.message,
                        translate: word,
                        type: 0,
                        from: user1,
                        to: int.parse(roomModel!.user2Id),
                        documentId:roomModel!.fireBaseChatId,
                        docField: "ff");
                    validationService.updateLastMessage
                      (appl.message, roomModel!.fireBaseChatId.toString());
                  } else {
                    final response = await validationService.addChat(
                        user1, roomModel!.user2Id,
                        roomModel!.fireBaseChatId);
                    validationService.addMessage(addOrUpdate: true,
                        text: appl.message,
                        translate: appl.message,
                        type: 0,
                        from: user1,
                        to: int.parse(roomModel!.user2Id),
                        documentId: roomModel!.fireBaseChatId,
                        docField: "ff");
                    /*      setState(() {
                  appl.chatId = response;



                });
*/
                    appl.chatId = response;
                    validationService.updateLastMessage(appl.message, roomModel!.fireBaseChatId);
                  }
                },
                    icon: Image.asset(
                      "assests/Icon ionic-ios-send.png", width: 20,)),

              ],),
            ),),
          );
        });
  }

}


class CheckMap extends StatelessWidget {
  CheckMap({Key? key,required this.documentId,required this.to,required this.user1}) : super(key: key);
var user1, documentId, to;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final validationService = Provider.of<ChatProvider>(context,listen: false);
    return Column(children: [

      textGlobalBlackNormal16(context: context,text: "هل انت متاكد من هذه الخطوه؟"),
      SizedBox(height: 20,),
      GestureDetector(onTap: () async {

        Position p= await validationService.determinePosition();
        if(p!=null)
          validationService.addMessage(addOrUpdate: true,
              text: "https://www.google.com/maps/search/?api=1&query=${p.latitude.toString()},${p.longitude.toString()}",
              translate: "https://www.google.com/maps/search/?api=1&query=${""},${""}",
              type: 4,
              from: user1,
              to: int.parse(to),
              documentId: documentId,
              docField: "ff");
        Navigator.of(context).pop();
      },child: buttonGlobal(context: context,text: "تاكيد")),
      SizedBox(height: 20,),
      GestureDetector(onTap: () async {
        Navigator.of(context).pop();
      },child: buttonGlobal(context: context,text: "الغاء"))



    ],);
  }



}

Widget checkImage(BuildContext context){

    // TODO: implement build
    final validationService = Provider.of<ChatProvider>(context,listen: false);
    return Column(children: [

      textGlobalBlackNormal16(context: context,text: "هل انت متاكد من هذه الخطوه؟"),
      SizedBox(height: 20,),
      GestureDetector(onTap: () async {
print("fff");
Navigator.of(context).pop();
 validationService.sendImage();

      },child: buttonGlobal(context: context,text: "تاكيد")),
      SizedBox(height: 20,),
      GestureDetector(onTap: () async {
        Navigator.of(context).pop();
      },child: buttonGlobal(context: context,text: "الغاء"))



    ],);




}