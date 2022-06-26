import 'dart:convert';

import 'package:translationchat/models/contactmodel.dart';
import 'package:translationchat/models/favmodel.dart';
import 'package:translationchat/models/lang_model.dart';
import 'package:translationchat/models/roommodel.dart';
import 'package:translationchat/services/firestorehandler.dart';
import 'package:translationchat/services/services_handler.dart';
import 'package:translationchat/utils/contacts.dart';
import 'package:translationchat/utils/sharedprefence.dart';

class ChatData{
FireStoreServices fireStoreServices=FireStoreServices();
ServicesHandler service = ServicesHandler();
  updateMessage({required translateMessage,required text,required  int type,required int from, required int to,required documentId,required docField}) {
    Map<String, dynamic> data = type == 0
        ? {
      "translateMessage":translateMessage,
      "message": text,

      "creationDt": DateTime.now(),
      "type": "text",
      "from": from,
      "to": to,
    } :type==1? {
      "creationDt": DateTime.now(),
      "type": "image",
      "message": text,
      "from": from,
      "to": to,
    }:type==2?{
      "translateMessage":text,
    }:type==3?{
      "message": text,
    }:type==4?{
      "creationDt": DateTime.now(),
      "type": "map",
      "message": text,
      "from": from,
      "to": to,
    }
    :{} ;


    if(text.toString().isNotEmpty) {





      fireStoreServices.updateCollection(map: data,

          doc: documentId,
          docField:docField,
          collectionName: "chat");


    }

  }
  updateLang({LangModel? langModel,user1,chatId}){
    Map<String, dynamic> data= {
      "lang":langModel!.lang,
      "code":langModel.code,
    };
    fireStoreServices.updateCollection(map: data,

        doc: chatId,
        docField:user1.toString(),
        collectionName: "lang");
  }

getMessage(doc)  {
  try {
    return  fireStoreServices.getDataStream(documentId: doc,collectionName: "chat",where: false);
  }catch(ex){
  rethrow;
  }
}

getLang(doc)  {
  try {
    return  fireStoreServices.getDataStream(documentId: doc,collectionName: "lang",where: false);
  }catch(ex){
    rethrow;
  }
}
Future translateWord(String target,String message) async{
 try {
   String token = await SharedPreferenceHandler.getToken();
   var headers = {
     'Authorization': 'Bearer ${token.toString()}'
   };
   var response = await service.
   postService(headers: headers,
       urlSuffix: "translate?target=${target.toString()}&message={$message}",
       returnBody: true).then((value) => value);

   String word = response["translated_message"];
   final withoutEquals = word.replaceAll(RegExp('}'), '').replaceAll(
       RegExp('{'), '');
   print(withoutEquals);
   return withoutEquals;
 }catch(ex){
   rethrow;
 }
}


updateLastMessage(String lastMessage,chatId) async {
  String token=await SharedPreferenceHandler.getToken();
  var headers = {
    'Authorization': 'Bearer ${token.toString()}'
  };
  var response= await service.postService(
  headers: headers,urlSuffix: "update-last-message?firebase_chat_id=${chatId.toString()}&last_message_received=${lastMessage.toString()}").then((value) => value);
  return response;

}
addChat({user1,user2,chatId}) async {
  String token=await SharedPreferenceHandler.getToken();
  var headers = {
    'Authorization': 'Bearer ${token.toString()}'
  };
  var response= await service.postService
    (returnBody: true,headers: headers,urlSuffix: "chats?user1=${user1.toString()}&user2=${user2.toString()}&firebase_chat_id=${chatId.toString()}").then((value) => value);
  return response["chat"]["firebase_chat_id"];
}

uploadImage(imageUrl) async {
  try {
    var response = await service.uploadImage(imageUrl,"upload-image",true);
   print(response);
    return response["image_url"];
  }catch(ex){
    rethrow;
  }
}



getContacts(contacts) async {

  String token=await SharedPreferenceHandler.getToken();
  var headers = {
    'Authorization': 'Bearer ${token.toString()}'
  };
  List <ContactModel> listContact=[];
  var body=  {
    "mobile_numbers":contacts.toString(),
  };
  var response= await ServicesHandler().
  postService(urlSuffix:"contacts",
      headers: headers,returnBody: true,requestBody: body);
  print(response);
  response["contacts"].forEach((v) {
    ContactModel contactModel = ContactModel.fromJson(v);
    listContact.add(contactModel);
  });
  return listContact;
}

getChats() async {
    List <RoomModel> listRoom=[];
    String token=await SharedPreferenceHandler.getToken();
    var headers = {
      'Authorization': 'Bearer ${token.toString()}'
    };
    var response= await ServicesHandler().
    getService(urlSuffix:"chats?",
        headers: headers, ex: true);

    response["chats"].forEach((v) {
    RoomModel roomModel = RoomModel.fromJson(v);
    listRoom.add(roomModel);
  });
    return listRoom;
  }


getLangauge() async {
  String token=await SharedPreferenceHandler.getToken();
  var headers = {
    'Authorization': 'Bearer ${token.toString()}'
  };
  List <LangModel> listFav=[];

  var response= await ServicesHandler().
  getService(urlSuffix:"languages",
       ex: true,headers: headers);

  print(response);
  response["languages"].forEach((k, v) => listFav.add(LangModel(lang:k, code: v)));
  return listFav;
}

getActives() async {
  List <RoomModel> listRoom=[];
  String token=await SharedPreferenceHandler.getToken();
  var headers = {
    'Authorization': 'Bearer ${token.toString()}'
  };
  var response= await ServicesHandler().
  postService(urlSuffix:"actives?",
      headers: headers, returnBody: true);
  response["actives"].forEach((v) {
   print("vvvvvvvvvvvvvv");
    print(v);
    if(v!=null) {
      RoomModel roomModel = RoomModel.fromJson(v);

      listRoom.add(roomModel);
    }
    });
  return listRoom;
}

getFav() async {

    List <FavModel> listFav=[];
    String token=await SharedPreferenceHandler.getToken();
    var headers = {
      'Authorization': 'Bearer ${token.toString()}'
    };
    var response= await ServicesHandler().
    getService(urlSuffix:"favorites?",
        headers: headers, ex: true);

    response["favorites"].forEach((v) {
      FavModel favModel = FavModel.fromJson(v);
      listFav.add(favModel);
    });
    return listFav;
  }

  addFav(favId,firebaseChatId)async
{

  try {
    String token=await SharedPreferenceHandler.getToken();
    var headers = {
      'Authorization': 'Bearer ${token.toString()}'

    };
    var response = await service.
    postService(urlSuffix: "favorites?favorite_person_id=${favId.toString()}&&firebase_chat_id=${firebaseChatId.toString()}",
        headers: headers,
        returnBody: false).then((value) => value);
    return response;
  }catch(ex){
    rethrow;
  }
}
deleteFav(favId)async
{

  try {
    String token=await SharedPreferenceHandler.getToken();
    var headers = {
      'Accept':"application/json",
      'Authorization': 'Bearer ${token.toString()}'
    };
    var response = await service.
    postService(urlSuffix: "delete-favorite?favorite_id=${favId.toString()}",
        headers: headers,
        returnBody: true).then((value) => value);
    return response;
  }catch(ex){
    rethrow;
  }
}


}




