import 'package:translationchat/models/roommodel.dart';

class FavModel{

//  late String chatId;
 // late String name;
//  late String fireBaseChatId;
 // late String lastMessage="";
 // String lastMessageTime;
  //late String user2Id;
RoomModel roomModel;
  FavModel({
  required this.roomModel });

factory FavModel.fromJson(Map<String, dynamic> json){

return FavModel(

    roomModel:
    RoomModel(user2Id:json["favorite"]["id"].toString(),
      updatedAt: json["favorite"]["updated_at"],
      isActive: json["favorite"]["is_active"],

      fireBaseChatId: json["firebase_chat_id"],
      email: json["favorite"]["email"],
      favoriteId: ["id"], chatId: json["firebase_chat_id"], imageUrl:
      json["favorite"]["image_url"]!=null?json["favorite"]["image_url"]:"",
      lastMessageTime: '', name: json["favorite"]["name"], lastMessage: '', mobileNumber: '',

    ) );
}
}