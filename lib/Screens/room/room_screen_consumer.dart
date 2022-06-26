import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translationchat/Screens/room/widgets_room/fav_message_widget.dart';
import 'package:translationchat/Screens/room/widgets_room/last_message_widget.dart';
import 'package:translationchat/provider/chatprovider.dart';
import 'package:translationchat/shared/components/progress.dart';
import 'package:translationchat/shared/text_global.dart';


class LastMessageRoom extends StatelessWidget {
  const LastMessageRoom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
  return  Consumer<ChatProvider>(
        builder: (context, provider, child) {
          if (provider.listRoomsGeneralState.hasData) {
            if(provider.listRoomsGeneralState.data!.isNotEmpty) {
              return LastMessageWidget(
                  roomModelList: provider.listRoomsGeneralState.data);
            }else{
           return Expanded(
                  child: Container(color: Colors.white, child:
                  Row(mainAxisAlignment: MainAxisAlignment.center,children: [    textGlobalBlackBold16(context: context,text: "ليس لديك رسائل")])))   ;
            }
            }else{
            //return progress();
            return Expanded(child: Container(color: Colors.white,child: progress()));
          }}
    );
  }
}

class LastActiveRoom extends StatelessWidget {
  const LastActiveRoom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<ChatProvider>(
        builder: (context, provider, child) {
          if (provider.listActiveState.hasData) {
            if(provider.listActiveState.data!.isNotEmpty) {
              return LastMessageWidget(
                  roomModelList: provider.listActiveState.data);
            }else{

              return Expanded(
                  child: Container(color: Colors.white, child:
      Row(mainAxisAlignment: MainAxisAlignment.center,children: [    textGlobalBlackBold16(context: context,text: "ليس لديك رسائل")])))   ;
            }
          } else {
            return Expanded(
                child: Container(color: Colors.white, child: progress()));
         //   return progress();
          }
        }
    );
  }
}
  class LastFavRoom extends StatelessWidget {
  const LastFavRoom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  // TODO: implement build
  return  Consumer<ChatProvider>(
  builder: (context, provider, child) {
  if (provider.listFavGeneralState.hasData) {
if(provider.listFavGeneralState.data!.isNotEmpty) {
  return FavMessageWidget();
}else{
  return Padding(padding: EdgeInsets.all(10.0),child: textGlobalWhiteBold20(context: context,text: "ليس لديك معارف مفضلين"));
}
  }else{
    return SizedBox(height: 10);
  }}
  );
  }
  }