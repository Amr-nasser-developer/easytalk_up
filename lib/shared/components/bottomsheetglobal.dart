import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translationchat/constants/colors.dart';
import 'package:translationchat/models/roommodel.dart';
import 'package:translationchat/provider/chatprovider.dart';
import 'package:translationchat/provider/userprovider.dart';
import 'package:translationchat/shared/components/displaysnackbar.dart';
import 'package:translationchat/shared/components/progress.dart';

import 'package:translationchat/shared/widgets/circleavatatimage.dart';
import 'package:translationchat/shared/text_global.dart';
import '../../Screens/chat/chat_screen_copy.dart';
import 'buttonglobal.dart';

bottomSheetGlobal({required BuildContext context,user1,chatId}) {
  showModalBottomSheet(

      isScrollControlled: true,
      context: context,
      elevation: 0,
      barrierColor: Colors.black.withAlpha(1),
      backgroundColor: Colors.transparent,
      builder: (context) {
  final   validationService = Provider.of<ChatProvider>(context);

   return       Container(
              height:400,

              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius:BorderRadius.all(Radius.circular(25.0)) ,
              ),
              child: Center(



  child:
  Consumer<ChatProvider>(
    builder: (context, provider, child){
  if(provider.listLangGeneralState.hasData==true) {
    return ListView.builder(
      itemCount: provider.listLangGeneralState.data!.length,
      itemBuilder: (context, index) {
        return FlatButton(onPressed: () async {
          validationService.chosenLangIndex =
          provider.listLangGeneralState.data![index];
          await validationService.updateLang(
              langModel: validationService.chosenLangIndex,
              user: user1,
              chatId: chatId);
          // validationService.notifyListeners();
//displaySnackBar(context, validationService.chosenLang);
          Navigator.of(context).pop();
        },
            child: Padding(padding: EdgeInsets.only(top: 20, bottom: 10),
                child: buttonGlobal(context: context,
                    text: provider.listLangGeneralState.data![index].lang)));
      },);
  }else{
    return progress();
        }
  }
 )



  ));});
}
bottomSheetGlobadl({required BuildContext context,required Widget body,required height}) {
  showModalBottomSheet(

      isScrollControlled: true,
      context: context,
      elevation: 0,
      barrierColor: Colors.black.withAlpha(1),
      backgroundColor: Colors.transparent,

      builder: (context) =>
          Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
                height:height,

                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:BorderRadius.all(Radius.circular(25.0)) ,
                ),
                child: Center(
                  child: SingleChildScrollView(
                      child:Column(
                          mainAxisSize: MainAxisSize.min,
                          children:[
                            body])
                  ),
                )
            ),
          ));

}
buttonAddImage(BuildContext context,icon,text){

  return  Padding(
    padding: const EdgeInsets.all(10),
    child: Container(color: cyan,child: Padding(
      padding: const EdgeInsets.all(10),
      child:  Row(mainAxisAlignment: MainAxisAlignment.center,children: [
       Icon(icon,size: 24,color: Colors.white,),
        textGlobalWhiteBold14(context: context,text: text),
      ],),
    ),),
  );
}




Widget addCamera( {required BuildContext context,required bool mainImage,required sortUploadImage}){

  final validationService = Provider.of<UserProvider>(
      context, listen: false);
  final validationService2 = Provider.of<ChatProvider>(
      context, listen: false);
  return Column(
      children: [
        GestureDetector( onTap: () async {
          if(sortUploadImage==true) {
            validationService.uploadImage(true);
          }else{
        await   validationService2.uploadImage(true);

        bottomSheetGlobadl(context: context, body: checkImage(context), height: 200.0);

          }
        },child:  buttonAddImage(context,Icons.camera,"اضافه عبر الكاميرا"), ),
        GestureDetector(onTap: () async {
          if(sortUploadImage==true) {
         await   validationService.uploadImage(false);
          }else{
            validationService2.uploadImage(false);
            Navigator.of(context).pop();
            bottomSheetGlobadl(context: context, body: checkImage(context), height: 200.0);
          }
        },child:buttonAddImage(context,Icons.filter,"اضافه من الاستديو")),
      ]);
}
bottomSheetProfile({required BuildContext context,required RoomModel roomModel}) {
  showModalBottomSheet(

      isScrollControlled: true,
      context: context,
      elevation: 0,
      barrierColor: Colors.black.withAlpha(1),
      backgroundColor: Colors.transparent,
      builder: (context) {
        final   validationService = Provider.of<ChatProvider>(context);

        return       Container(
            height:300,

            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius:BorderRadius.all(Radius.circular(25.0)) ,
            ),
            child: Center(



                child:Column(children: [
                  const SizedBox(height: 30,),
         Center(child: circleAvatarImage(roomModel.imageUrl,false), ),
            textGlobalBlackBold16(context: context,text: roomModel.name),
                  const SizedBox(height: 20,),
                  textGlobalBlackBold16(context: context,text: roomModel.email),
                  const SizedBox(height: 20,),

                  textGlobalBlackBold16(context: context,text: roomModel.mobileNumber),
                 const SizedBox(height: 20,),

  Consumer<UserProvider>(
  builder: (context, provider, child) {
    if(roomModel.favoriteId!=null){

  return FlatButton(onPressed: () async {
  var response =await validationService.deleteFav(fav: roomModel.favoriteId);
  if(response[0]=="deleted"){
 await validationService.getFav();
await  validationService.getChats();
 Navigator.of(context).pop();

 //bottomSheetProfile(context: context,roomModel: roomModel);
  }
  }, child: Icon(Icons.favorite,color: cyan,));
  }
 else {
      return FlatButton(onPressed: () {

      }, child: FlatButton(onPressed: () async {
        print("//////////////////////////////");

        var response = await validationService.addFav(
            fav: roomModel.user2Id, firebasehatId: roomModel.fireBaseChatId);
        print(response);

        if (response == 200||response==201) {
          validationService.getFav();
          validationService.getChats();
          Navigator.of(context).pop();
        }
      }, child: Icon(Icons.favorite_border, color: cyan,)));
    }
  }),


        ],))



        );});
}