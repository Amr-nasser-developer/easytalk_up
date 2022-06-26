

import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:translationchat/constants/strring.dart';
import 'package:translationchat/data/chatdata.dart';
import 'package:translationchat/models/ProviderGeneralState.dart';
import 'package:translationchat/models/contactmodel.dart';
import 'package:translationchat/models/favmodel.dart';
import 'package:translationchat/models/lang_model.dart';
import 'package:translationchat/models/messagemodel.dart';
import 'package:translationchat/models/roommodel.dart';
import 'package:translationchat/utils/contacts.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatProvider extends ChangeNotifier{
  ChatData chatData= ChatData();
  bool  emojiShowing=true;
  bool isKeyboardVisible = false;
  List <Message>   messageList = [];
  bool settingLang=true;
  //List <LangModel> langList=[LangModel(lang: "française", code: "fr"),LangModel(lang: "English",code: "en"),LangModel(lang: "العربيه", code: "ar"),LangModel(lang: "Idioma italiano",code: "it")];
  LangModel chosenLangIndex=LangModel(lang: "العربيه", code: "ar");
  late LangModel user=chosenLangIndex;
  late LangModel anotherUser=chosenLangIndex;
  bool switchRoom=false;
  late Message message;
  
  late ProviderGeneralState<List <ContactModel>> listContactsGeneralState=ProviderGeneralState(waiting: true);
  late ProviderGeneralState<List <RoomModel>> listRoomsGeneralState;
  late ProviderGeneralState<List <LangModel>> listLangGeneralState;
  late ProviderGeneralState<List <FavModel>> listFavGeneralState=ProviderGeneralState(waiting: true);
  late ProviderGeneralState<List <RoomModel>> listActiveState;
  listen(){

    notifyListeners();
  }

  changeLang(){
    if(settingLang==true){
      settingLang=false;
      notifyListeners();
    }else{
      settingLang=true;
      notifyListeners();
    }

  }

  File? mainImage;
  sendImage() async {

    var response  =await  chatData.uploadImage(mainImage);

print(response);
     addMessage(translate: response, addOrUpdate:true, text: response, type: 1, from:int.parse( message.from.toString()), to:int.parse( message.to.toString()), documentId: message.documentId, docField: "");

    // notifyListeners();
  }
  Future  uploadImage(bool cameraORGallery) async {
    final picker = ImagePicker();
    ImagePicker _picker = ImagePicker();
    final PickedFile? file = await _picker.getImage(
        source: cameraORGallery == true ? ImageSource.camera : ImageSource.gallery,
        imageQuality: 50);
    File tmpFile = File(file!.path);
    print(tmpFile.path);
    mainImage = tmpFile;

  }

  emojShowingBoolean(){
    if(emojiShowing==true) {
      emojiShowing = false;
notifyListeners();
    }else{
      emojiShowing = true;
notifyListeners();
    }

  }

  emojShowingfalse(){

      emojiShowing = true;
      notifyListeners();


  }

  launchURL(googleMapslocationUrl) async {

      //  const String homeLat = "37.3230";
     //const String homeLng = "-122.0312";

   //final String googleMapslocationUrl = "https://www.google.com/maps/search/?api=1&query=${homeLat},${homeLng}";



    final String encodedURl = Uri.encodeFull(googleMapslocationUrl);

    if (await canLaunch(encodedURl)) {
      await launch(encodedURl);
    } else {
      print('Could not launch $encodedURl');
      throw 'Could not launch $encodedURl';
    }
  }

  addMessage({required String translate,required bool addOrUpdate,required text,required  int type,required int from, required int to,required documentId,required docField}){
    try{
      print("///////");
print(translate);

      chatData.updateMessage(translateMessage: translate,text: text, type: type,
          from: from, to: to, documentId: documentId, docField: addOrUpdate==true?getRandomString():docField);

    }catch(ex){
      rethrow;
    }
  }
  updateLang({required LangModel langModel,chatId,user}) async {
    try{
  await chatData.updateLang(langModel:langModel,chatId: chatId,user1: user);
    }catch(ex){
      rethrow;
    }
  }

  getLangauge() async {

      try {
        List <LangModel> getLang = [];
        setWaiting(4);
        getLang = await chatData.getLangauge();
        listLangGeneralState =
            ProviderGeneralState(data: getLang, hasData: true);
        notifyListeners();
      }catch(ex){
        rethrow;
      }
    }




  translateWord({target,message}) async {
    try{
      String word   = await chatData.translateWord(target, message);
      return word;

    }catch(ex){
      rethrow;
    }
  }

 getLangList( documentSnapshot,userOne) async {

    if (documentSnapshot.data != null) {
      if (documentSnapshot.data.data() != null) {
        await documentSnapshot.data.data().forEach((key, value) {
          if (key == userOne.toString()) {
            user = LangModel(code: value["code"], lang: value["lang"]);
            print(user);
          } else {
            anotherUser = LangModel(code: value["code"], lang: value["lang"]);
            print(anotherUser);
          }
        });
      }
    }
  }
  changeSwitch(){
    if(switchRoom==true){
      switchRoom=false;
      getChats();
      notifyListeners();
    }else{
      switchRoom=true;
      getActives();
      notifyListeners();
    }
notifyListeners();
  }
  addFav({fav,firebasehatId}) async {
    try{
    return chatData.addFav(fav,firebasehatId);


    }catch(ex){
      rethrow;
    }
  }
  deleteFav({fav}) async {
    try{
    return chatData.deleteFav(fav);


    }catch(ex){
      rethrow;
    }
  }
  getMessage(chatId) {
    try {


         return chatData.getMessage(chatId);
    } catch (ex) {
rethrow;
    }
  }
  
  getLang(chatId) {
    try {
      return chatData.getLang(chatId);
    } catch (ex) {
      rethrow;
    }
  }
  printMessage(documentSnapshot) async {
    messageList.clear();
    messageList = [];

    try {
      if (documentSnapshot.data != null) {
      await documentSnapshot.data.data().forEach((key, value) {

Timestamp timestamp=value["creationDt"];
          messageList.add( Message(
            creationDt: timestamp.toDate(),
            message: value["message"].toString(),
            type: value["type"],
            translateMessage: value["translateMessage"],
            to: value["to"],
                    from: value["from"], documentId: key,
          ));
          messageList.sort();

        });
      }
    }catch(ex){
      print("error get msg list "+ex.toString());
    }
  }
  GetContacts getContacts=GetContacts();
getContact() async {
final contacts=await   GetContacts.fetchContacts();
return contacts;
}
addChat(user1,user2,chatId) async {
final response= await chatData.addChat(user1:user1,user2:user2,chatId:chatId);
return response;
}

getActives() async {

    List <RoomModel> getActive = [];
    setWaiting(3);
    getActive = await chatData.getActives();
    listActiveState =
        ProviderGeneralState(data: getActive, hasData: true);
    notifyListeners();


}

getChats() async {
 try {
   List <RoomModel> getRoom = [];
   setWaiting(1);
   getRoom = await chatData.getChats();
   listRoomsGeneralState =
       ProviderGeneralState(data: getRoom, hasData: true);
   notifyListeners();
 }catch(ex){
   rethrow;
 }
}
  getFav() async {
    try {
      List <FavModel> getFav = [];
      setWaiting(2);
      getFav = await chatData.getFav();
     listFavGeneralState =
          ProviderGeneralState(data: getFav, hasData: true);
      notifyListeners();
    }catch(ex){
      rethrow;
    }
  }

  getListContacts(contacts) async {
    setWaiting(0);
  List <ContactModel> listContacts =await chatData.getContacts(contacts);
    listContactsGeneralState =
        ProviderGeneralState(data: listContacts, hasData: true);

    notifyListeners();
  }
  updateLastMessage(lastMessage,chatId) async {
  await chatData.updateLastMessage(lastMessage,chatId);
  }
  void setWaiting(index) {
    switch (index) {
      case 0:
        listContactsGeneralState = ProviderGeneralState(waiting: true);
        break;
      case 1:
        listRoomsGeneralState = ProviderGeneralState(waiting: true);
        break;
      case 2:
        listFavGeneralState = ProviderGeneralState(waiting: true);
        break;
      case 3:
        listActiveState = ProviderGeneralState(waiting: true);
        break;
      case 4:
        listLangGeneralState = ProviderGeneralState(waiting: true);
        break;

    }
  }
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();

  }


}