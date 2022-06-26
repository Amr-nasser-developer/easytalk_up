import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translationchat/Screens/chat/contactscreen.dart';
import 'package:translationchat/Screens/room/room_screen_consumer.dart';
import 'package:translationchat/constants/colors.dart';
import 'package:translationchat/provider/chatprovider.dart';
import 'package:translationchat/shared/components/drawer.dart';
import 'package:translationchat/shared/components/navigator.dart';
import 'package:translationchat/shared/components/sizedboxglobal.dart';
import 'package:translationchat/shared/text_global.dart';

class RoomBody extends StatelessWidget {


  RoomBody({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final validationService = Provider.of<ChatProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: navigationDrawer(),
        backgroundColor: darkCyan,
        body: Center(
            child: Container(
              //padding: const EdgeInsets.only(10),
              height: MediaQuery.of(context).size.height,
              color: cyan,
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 0, right: 0),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: () {
                                _scaffoldKey.currentState!.openDrawer();
                              },
                              child: const Icon(
                                Icons.menu,
                                color: Colors.white,
                              )),
                       /*   const Icon(
                            Icons.search,
                            color: Colors.white,
                          ),*/
                        ],
                      ),
                    ),
        Consumer<ChatProvider>(
        builder: (context, provider, child) {
                  return  Directionality(
                      textDirection: TextDirection.rtl,
                      child: Padding(
                        padding:
                        const EdgeInsets.only(top: 10, left: 40, right: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                             onTap: (){


                                 print(validationService.switchRoom);
                                 validationService.changeSwitch();

                             } ,
                          child:  textGlobalWhiteBold14(
                                context: context, text:validationService.switchRoom==false? "الرسائل":"نشط الان")),
                            GestureDetector(onTap:(){

                                validationService.changeSwitch();

                            } ,child:
                            textGlobalGreyBold13(
                                context: context, text:validationService.switchRoom==true?  "الرسائل":"نشط الان")),
                          ],
                        ),
                      ),
                    );}),
                    sizedBoxGlobalHeight10(),
                    Expanded(
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(30.0),
                                  topRight: Radius.circular(30.0)),
                             gradient:  LinearGradient(

                                 colors: <Color>[gradint2,gradint2]),
                            ),

                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top:5, left: 20, right: 20, bottom: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [


                                        textGlobalWhiteBold24(
                                            context: context, text: "..."),
                                        textGlobalWhiteNormal16(
                                            context: context,
                                            text: "المتصلين المفضلين"),
                                      ],
                                    ),
                                  ),
                                  const LastFavRoom(),

                                  Consumer<ChatProvider>(
    builder: (context, provider, child) {
    if (validationService.switchRoom==false) {
      return  LastMessageRoom();
    }else{
      return const LastActiveRoom();

    }}),

                              ]),
                            ) /*  */))
                  ],
                ),
              ),
            )),
          floatingActionButtonLocation:
          FloatingActionButtonLocation.miniStartFloat,
        floatingActionButton: Container(
          
          decoration: BoxDecoration(

          borderRadius:BorderRadius.circular(55)

          ,color:darkCyan ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: InkWell(
              onTap:  () async {
                AppNavigator.navigateTo(context, const ContactScreen());
                // await validationService.getContact();
              },
              child:  Container(
                decoration: BoxDecoration(
                    borderRadius:BorderRadius.circular(53)
                    ,gradient:  LinearGradient(colors: [gradint1,gradint2])),
                child: CircleAvatar(
backgroundColor: Colors.transparent,
                   radius: 25 ,
                    child: Icon(Icons.chat_bubble,color: Colors.white,),

                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }




}