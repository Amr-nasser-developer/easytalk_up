import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translationchat/Screens/galleryview/gallery_view.dart';
import 'package:translationchat/constants/colors.dart';
import 'package:translationchat/provider/chatprovider.dart';
import 'package:translationchat/shared/components/navigator.dart';
import 'package:translationchat/shared/text_global.dart';

class MessageComponents extends StatelessWidget {
  int index;
  bool checkMessage;
  int user1;
  MessageComponents(
      {required this.index, required this.checkMessage, required this.user1});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final validationService = Provider.of<ChatProvider>(context, listen: false);

    if (validationService.messageList[index].type == "image") {
      return Row(
              mainAxisAlignment:
                  validationService.messageList[index].from == user1
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: (){
                    AppNavigator.navigateTo(context, ItemGalleryView(img:     validationService.messageList[index].message
                        .toString()));
                  },
                  child: Container(
                      height: 200,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            topRight: Radius.circular(15)),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.network(
                            validationService.messageList[index].message
                                .toString(),
                            height: 200,
                            fit: BoxFit.fill,
                          ))),
                )
              ]);
    } else if (validationService.messageList[index].type == "map") {
      return   Row(
                mainAxisAlignment:
                    validationService.messageList[index].from == user1
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                children: [

                  InkWell(
                      onTap: () {
                        validationService.launchURL(
                          validationService.messageList[index].message.toString(),
                        );
                      },child:
                  Container(
                      height: 200,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            topRight: Radius.circular(15)),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset(
                            "assests/png-clipart-cracked-screens-location-link-free-city-map-map-map-location.png",
                            height: 200,
                            fit: BoxFit.fill,
                          )))),




      ]);
    } else {
      return Directionality(
        textDirection: validationService.messageList[index].from == user1
            ? TextDirection.ltr
            : TextDirection.rtl,
        child: Padding(
          padding: validationService.messageList[index].from == user1?EdgeInsets.only(left: 40,right: 10):
          EdgeInsets.only(right: 40,left: 10),
          child: Container(
            padding: EdgeInsets.only(left: 5,right: 5),
              decoration: BoxDecoration(
                color: validationService.messageList[index].from != user1
                    ? yellow
                    : lightCyan,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
              ),
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: validationService.messageList[index].from != user1
                      ? textGlobalBlackBold14(
                          context: context,
                          text: checkMessage == true
                              ? validationService.messageList[index].translateMessage
                              : validationService
                                  .messageList[index].message)
                      : textGlobalWhiteBold14(
                          context: context,
                          text: checkMessage == true
                              ? validationService
                                  .messageList[index].message
                              : validationService
                                  .messageList[index].translateMessage))),
        ),
      );
    }
  }
}
