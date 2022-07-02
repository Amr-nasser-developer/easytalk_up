import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart'
    show
        BuildContext,
        Center,
        Column,
        CupertinoSwitch,
        EdgeInsets,
        Key,
        State,
        StatefulWidget,
        TextEditingController,
        Widget;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:translationchat/Screens/room/roomscreen.dart';
import 'package:translationchat/constants/colors.dart';
import 'package:translationchat/constants/strring.dart';
import 'package:translationchat/models/roommodel.dart';
import 'package:translationchat/provider/chatprovider.dart';
import 'package:translationchat/shared/components/bottomsheetglobal.dart';
import 'package:translationchat/shared/components/sizedboxglobal.dart';
import 'package:translationchat/shared/components/textfieldglobal.dart';

import 'package:translationchat/shared/emojy_list.dart';
import 'package:translationchat/shared/text_global.dart';
import 'package:translationchat/shared/widgets/circleavatatimage.dart';

class ChatScreeng extends StatefulWidget {
  RoomModel? roomModel;
  String user1 = "";
  bool roomBool;

  ChatScreeng(
      {Key? key, this.roomModel, required this.user1, required this.roomBool})
      : super(key: key);
  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreeng> {
  // const _SignUpState({Key? key}) : super(key: key);const MyHomePage({Key? key, required this.title}) : super(key: key);
  ScrollController? _controller;
  String? x;

  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Query

    // Subscribe
  }

  bool emojiShowing = false;
  bool isKeyboardVisible = false;
  final focusNode = FocusNode();
  _onEmojiSelected(String emoji) {
    setState(() {
      controller.text = controller.text + emoji;
    });
  }

  _onBackspacePressed() async {
    if (emojiShowing == true) {
      setState(() {
        emojiShowing = false;
      });
    } else {
      var data = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RoomScreen()),
      );

      return data;
    }
  }

  on() {
    final validationService = Provider.of<ChatProvider>(context);
    validationService.getChats();
    Navigator.of(context).pop();
  }

  Future toggleEmojiKeyboard() async {
    if (isKeyboardVisible) {
      FocusScope.of(context).unfocus();
    }

    setState(() {
      emojiShowing = !emojiShowing;
    });
  }

  @override
  Widget build(BuildContext context) {
    final validationService = Provider.of<ChatProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        _onBackspacePressed();
        return true;
        // return  validationService.getChats();
      },
      child: SafeArea(
        child: Scaffold(
            backgroundColor: cyan,
            body: Center(
                child: Container(
              height: MediaQuery.of(context).size.height,
              color: cyan,
              child: Column(
                children: [
                  sizedBoxGlobalHeight10(),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            )),
                        CupertinoSwitch(
                          trackColor: Colors.white,
                          activeColor: yellow,
                          value: validationService.settingLang,
                          onChanged: (value) {
                            setState(() {
                              if (validationService.settingLang == true) {
                                validationService.settingLang = false;
                              } else {
                                validationService.settingLang = true;
                              }
                            });
                          },
                        ),

                        /*GestureDetector(onTap:(){
                   setState(() {

                     if(validationService.settingLang==true){
                       validationService.settingLang=false;
                     }else{
                       validationService.settingLang=true;
                     }
                   });
                 } ,
                     child:
                     validationService.settingLang==true?
                     Image.asset("assests/Group 1344.png"):
                     Image.asset("assests/Group 1345.png"))*/
                      ],
                    ),
                  ),
                  sizedBoxGlobalHeight10(),
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0)),
                      color: Colors.grey.shade100,
                    ),
                    child: Column(
                      children: [
                        sizedBoxGlobalHeight20(),
                        textGlobalDarkCyanBold13(
                            context: context, text: widget.roomModel!.name),
                        // textGlobalDarkCyanBold13(context: context,text: "كان نشطامنذ خمس دقائق"),
                        validationService.settingLang == true
                            ? GestureDetector(
                                onTap: () {
                                  bottomSheetGlobal(
                                      context: context,
                                      user1: widget.user1,
                                      chatId: widget.roomModel!.fireBaseChatId);
                                },
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Center(
                                    child: Container(
                                      width: 200,
                                      padding:
                                          const EdgeInsets.only(left: 12.0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        color: cyan,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          sizedBoxGlobalWidth20(),
                                          const Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Colors.white,
                                          ),
                                          StreamBuilder<DocumentSnapshot>(
                                              stream: validationService.getLang(
                                                  widget.roomModel!
                                                      .fireBaseChatId),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<
                                                          DocumentSnapshot>
                                                      snapshot) {
                                                //  validationService.getLangList(snapshot, widget.user1);
                                                return textGlobalWhiteNormal16(
                                                    context: context,
                                                    text: validationService
                                                        .user.lang
                                                        .toString());
                                              }),

                                          /*Consumer<ChatProvider>(
    builder: (context, provider, child) {


    return                            textGlobalWhiteNormal16(
                                    context: context, text: provider.chosenLangIndex.lang);
    })*/
                                          sizedBoxGlobalWidth20(),
                                          const Icon(
                                            Icons.map,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox(height: 20),

                        StreamBuilder<DocumentSnapshot>(
                            stream: validationService
                                .getMessage(widget.roomModel!.fireBaseChatId),
                            builder: (BuildContext context,
                                AsyncSnapshot<DocumentSnapshot> snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.green,
                                    // #to_do handling the progess bar to be stop if there no connecction
                                    // or error happened
                                  ),
                                );
                              } //end
                              else if (snapshot.hasError) {
                                return new Text("");
                                // #to_do handling the progess bar to be stop if there no connecction
                                // or error happened
                              } else {
                                if (snapshot.data != null) {
                                  validationService.printMessage(snapshot);

                                  return Expanded(
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        reverse: true,
                                        controller: _controller,
                                        padding: const EdgeInsets.all(10),
                                        itemCount: validationService
                                            .messageList.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Directionality(
                                              textDirection: validationService
                                                          .messageList[index]
                                                          .from
                                                          .toString() ==
                                                      widget.user1.toString()
                                                  ? TextDirection.rtl
                                                  : TextDirection.ltr,
                                              child: Row(
                                                children: [
                                                  circleAvatarImage(
                                                      null, false),
                                                  sizedBoxGlobalWidth10(),
                                                  Expanded(
                                                      child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                              child: message(
                                                                  index, true))
                                                        ],
                                                      ),
                                                      /*                                  validationService.settingLang==true?GestureDetector(onTap: () async {


  //translateWord(index,context);

  String word = await validationService
      .translateWord(
      target: validationService
          .chosenLangIndex.code,
      message: validationService
          .messageList[index]
          .message);

  validationService
      .addMessage(
    translate: word,
      addOrUpdate: false,
      text: word,
      type: 2,
      from: 7182,
      to: 8182,
      documentId: widget
          .roomModel!
          .fireBaseChatId,
      docField: validationService
          .messageList[index]
          .documentId);
   },child:  CircleAvatar(
  radius: 15,
  backgroundColor: Colors.black,
  child: CircleAvatar(
    backgroundColor: Colors.white,
    radius: 13,
 child: Padding(padding: EdgeInsets.all(10),child: Image.asset("assests/Iconmaterial-translate.png",width: 40,height: 20,),),
  ),
)):SizedBox(),*/
                                                      /*validationService.settingLang==true?          Row(children:
                                        [Expanded(child:  message(index,false))],):SizedBox(height: 0,),*/
                                                      textGlobalBlackBold16(
                                                          text: formatDate(
                                                              validationService
                                                                  .messageList[
                                                                      index]
                                                                  .creationDt,
                                                              [
                                                                dd,
                                                                '/',
                                                                mm,
                                                                '/',
                                                                yyyy,
                                                                ' ',
                                                                HH,
                                                                ':',
                                                                nn
                                                              ]),
                                                          context: context),
                                                    ],
                                                  )),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  );
                                } else {
                                  return Text("");
                                }
                              }
                            }),

                        comButton(context),
                        emojyPicker(),
                      ],
                    ),
                  )),
                ],
              ),
            ))),
      ),
    );
  }

  Widget comButton(BuildContext context) {
    final validationService = Provider.of<ChatProvider>(context);

    return Padding(
      padding:
          const EdgeInsets.only(left: 20, right: 20, bottom: 10.0, top: 10.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: darkCyan,
          borderRadius: const BorderRadius.all(Radius.circular(25)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            children: [
              GestureDetector(
                  onTap: () {
                    setState(() {
                      emojiShowing = !emojiShowing;
                    });
                  },
                  child: Image.asset(
                    "assests/Iconfeather-smile.png",
                    width: 20,
                  )),
              Expanded(
                  child: TextFieldGlobal(
                myFocusNode: focusNode,
                focus: true,
                keyboardType: TextInputType.text,
                controller: controller,
                label: darkCyan,
                hint: '',
                widthBorder: 0.0,
              )),
              sizedBoxGlobalWidth10(),
              const Icon(
                Icons.image,
                color: Colors.white,
              ),
              sizedBoxGlobalWidth10(),
              GestureDetector(
                  onTap: () async {
                    appl.message = controller.text;
                    setState(() {
                      controller.text = "";
                    });
                    print(validationService.messageList.length);
                    if (validationService.messageList.isNotEmpty) {
                      if (widget.roomBool == true) {
                        //   appl.chatId=int.parse( widget.roomModel!.chatId);
                      }
                      String word = await validationService.translateWord(
                          target: validationService.anotherUser.code,
                          message: appl.message);
                      print(word);
                      validationService.addMessage(
                          addOrUpdate: true,
                          text: appl.message,
                          translate: word,
                          type: 0,
                          from: int.parse(widget.user1),
                          to: int.parse(widget.roomModel!.user2Id),
                          documentId: widget.roomModel!.fireBaseChatId,
                          docField: "ff",
                      );
                      validationService.updateLastMessage(
                          appl.message, appl.chatId.toString());
                    } else {
                      final response = await validationService.addChat(
                          widget.user1,
                          widget.roomModel!.user2Id,
                          widget.roomModel!.fireBaseChatId);
                      validationService.addMessage(
                          addOrUpdate: true,
                          text: appl.message,
                          translate: appl.message,
                          type: 0,
                          from: int.parse(widget.user1),
                          to: int.parse(widget.roomModel!.user2Id),
                          documentId: widget.roomModel!.fireBaseChatId,
                          docField: "ff");
                      setState(() {
                        appl.chatId = response;

                        print(appl.chatId);
                      });

                      validationService.updateLastMessage(
                          appl.message, response);
                    }
                  },
                  child: Image.asset(
                    "assests/Icon ionic-ios-send.png",
                    width: 20,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  message(index, bool checkMessage) {
    final validationService = Provider.of<ChatProvider>(context);

    return Container(
        decoration: BoxDecoration(
          color: validationService.messageList[index].from.toString() ==
                  widget.user1
              ? Colors.white
              : lightCyan,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(15), topRight: Radius.circular(15)),
        ),
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: validationService.messageList[index].from.toString() ==
                    widget.user1
                ? textGlobalDarkCyanBold13(
                    context: context,
                    text: checkMessage == true
                        ? validationService.messageList[index].message
                        : validationService.messageList[index].translateMessage)
                : textGlobalWhiteBold14(
                    context: context,
                    text: checkMessage == true
                        ? validationService.messageList[index].translateMessage
                        : validationService
                            .messageList[index].translateMessage)));
  }

  emojyPicker() {
    return Offstage(
      offstage: !emojiShowing,
      child: SizedBox(
        height: 250,
        child: EmojiPicker(
            onEmojiSelected: (Category category, Emoji emoji) {
              _onEmojiSelected(emoji.emoji);
            },
            onBackspacePressed: _onBackspacePressed,
            config: Config(
                columns: 7,
                // Issue: https://github.com/flutter/flutter/issues/28894
                emojiSizeMax: 64 * (Platform.isIOS ? 1.30 : 1.0),
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
  }

  translasteWord(index, BuildContext context) async {}
}
