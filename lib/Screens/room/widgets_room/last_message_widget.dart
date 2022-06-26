import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translationchat/Screens/chat/chat_screen_copy.dart';
import 'package:translationchat/Screens/chat/chatscreen.dart';
import 'package:translationchat/models/providergeneralstate.dart';
import 'package:translationchat/models/roommodel.dart';
import 'package:translationchat/provider/chatprovider.dart';
import 'package:translationchat/provider/userprovider.dart';
import 'package:translationchat/shared/components/bottomsheetglobal.dart';
import 'package:translationchat/shared/components/navigator.dart';
import 'package:translationchat/shared/components/sizedboxglobal.dart';
import 'package:translationchat/shared/text_global.dart';
import 'package:translationchat/shared/widgets/circleavatatimage.dart';

class LastMessageWidget extends StatelessWidget {
var  roomModelList;
  LastMessageWidget({required this.roomModelList});
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChatProvider>(context,listen: false);

    // TODO: implement build
    return  Expanded(
      child: Container(width: MediaQuery.of(context).size.width,decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0)),


        color: Colors.grey.shade100,

      ),child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(children: [

          Expanded(child:  ListView.builder(
              itemCount: roomModelList.length,
              itemBuilder: (BuildContext context,int index){
 return LastMessageComponents(roomModel: roomModelList[index]);
              }
          ),),

        ],),
      ),),
    );
  }
}

class LastMessageComponents extends StatelessWidget {
  RoomModel roomModel;
  LastMessageComponents({required this.roomModel});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final validationService2 = Provider.of<UserProvider>(context,listen: false);
    return GestureDetector(
      onTap: (){

        AppNavigator.navigateTo(context, ChatScreen(
            roomBool: true,
            roomModel:
           roomModel,
            user1: validationService2.
            listUserProfileGeneralState.data!.idModify));
      },
      child: Padding(
        padding:const EdgeInsets.only(left: 15.0,right:15.0,top: 15.0 ),
        child: Column(children: [
          FlatButton(
            onPressed: (){
              AppNavigator.navigateTo(context, ChatScreen(roomBool: true,
                  roomModel: roomModel,user1: validationService2.listUserProfileGeneralState.data!.idModify));

            },
            child: Container(
              child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                Row(children: [
                  GestureDetector(onTap: (){
                    bottomSheetProfile( context: context,roomModel:  roomModel);

                  },child: circleAvatarImage(roomModel.imageUrl,false)),
                  sizedBoxGlobalWidth20(),
                  Column(children: [
                    Row(children: [
                      Directionality(textDirection: TextDirection.rtl, child:
                      SizedBox(width:
                      MediaQuery.of(context).size.width-250,
                          child: textGlobalLightCyanNormal12(context: context,text: roomModel.name),),
                      )]),





                    Row(children: [
                      Directionality(textDirection: TextDirection.rtl, child:
                      SizedBox(width:
                    MediaQuery.of(context).size.width-250,
                      child: textGlobalBlackBold13(context: context,text: roomModel.lastMessage)),
                    )]),
                  ],),



                ]),


                textGlobalGreyNormal13(context: context,text: roomModel.lastMessageTime),
              ],)




                // textGlobalBlackNormal13(context: context,text: provider.listRoomsGeneralState.data![index].lastMessageTime),

            ),
          )
          , const Divider(color: Colors.grey,thickness: 1,)
        ],),
      ),
    );
  }

}