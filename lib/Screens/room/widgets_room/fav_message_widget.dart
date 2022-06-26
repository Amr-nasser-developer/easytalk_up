import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:translationchat/Screens/chat/chat_screen_copy.dart';
import 'package:translationchat/provider/chatprovider.dart';
import 'package:translationchat/provider/userprovider.dart';
import 'package:translationchat/shared/components/navigator.dart';
import 'package:translationchat/shared/text_global.dart';
import 'package:translationchat/shared/widgets/circleavatatimage.dart';

class FavMessageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final provider = Provider.of<ChatProvider>(context,listen: false);
    final validationService2 = Provider.of<UserProvider>(context,listen: false);
    return SizedBox(
      height: 85,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: provider
              .listFavGeneralState.data!.length,
          itemBuilder:
              (BuildContext context, int index) =>
              GestureDetector(
                onTap: () {

                  AppNavigator.navigateTo(context, ChatScreen(
                      roomBool: true,
                      roomModel:
                      provider
                          .listFavGeneralState.data![index].roomModel,
                      user1: validationService2.
                      listUserProfileGeneralState.data!.idModify));
                },
                child: Padding(
                  padding:
                  const EdgeInsets.all(2),
                  child: Column(
                    children: [
                      circleAvatarImage(
                          provider
                              .listFavGeneralState
                              .data![index].roomModel
                              .imageUrl, false),
               SizedBox(width:40 ,child:      textGlobalNormalWhite14(
                          context: context,
                          text: provider
                              .listFavGeneralState
                              .data![index].roomModel
                              .name))
                    ],
                  ),
                ),
              )),
    );
  }






}