import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:translationchat/models/usermodel.dart';
import 'package:translationchat/services/firebasehandler.dart';
import 'package:translationchat/services/services_handler.dart';
import 'package:translationchat/utils/sharedprefence.dart';

class UserData {
  ServicesHandler service = ServicesHandler();
  FirebaseHandler firebaseHandler=FirebaseHandler();
  Future  getToken(String mobileNumber) async {
 try {
   String? tokenFcm = await FirebaseMessaging.instance.getToken();
   print("/////////////////////////////////////////////");
   print (tokenFcm);

   var response = await service.
   postService(urlSuffix: "login?mobile_number=${mobileNumber.toString()}&fcm_token=${tokenFcm.toString()}",
       returnBody: true).then((value) => value);
   String token = response["token"];
   await SharedPreferenceHandler.setToken(token);

   await SharedPreferenceHandler.setIntro();
userIsOLine();
   return 0;
 }catch(ex){
   return 1;
 }
  }


  userIsOLine() async {
    print("gggggg");
    String token=await SharedPreferenceHandler.getToken();
    var headers = {
      'Accept':"application/json",
      'Authorization': 'Bearer ${token.toString()}'
    };
    var response= await ServicesHandler().getService(urlSuffix:"online", ex: true,headers: headers);
print(response);
    return response;
  }

  getInformation(key) async {
    String token=await SharedPreferenceHandler.getToken();
    var headers = {
      'Accept':"application/json",
      'Authorization': 'Bearer ${token.toString()}'
    };
    var response= await ServicesHandler().getService(urlSuffix:"information", ex: true,headers: headers);
    return response["information"]["${key.toString()}"];
  }

  userIsOffline() async {
    String token=await SharedPreferenceHandler.getToken();
    var headers = {
      'Accept':"application/json",
      'Authorization': 'Bearer ${token.toString()}'
    };
     await ServicesHandler().getService(urlSuffix:"offline", ex: true,headers: headers);

  }


 getMobileNumber({mobileNumber,countryCode}){
try{

    firebaseHandler.phoneAuth("+${countryCode.toString()}${mobileNumber.toString()}");
}catch(ex){
  rethrow;
}

}

updateNumber(mobileNumber) async {
  try{
    String token=await SharedPreferenceHandler.getToken();
    var headers = {
      'Accept':"application/json",
      'Authorization': 'Bearer ${token.toString()}'
    };
    var response = await service.
  postService(urlSuffix: "update-number?mobile_number=${mobileNumber.toString()}",headers: headers,
      returnBody: false).then((value) => value);
  return response;
}catch(ex){
  rethrow;
  }
}

checkCode({smsCode}) async{
    try{

  var value   = await firebaseHandler.checkCode(smsCode);

   return value;
    }catch(ex){
      return false;
    }
}




 logOut() async {
   try {
     var response = await service.
     postService(urlSuffix: "logout",
         returnBody: false).then((value) => value);
     return response;
   }catch(ex){
     rethrow;
   }

 }

  disableAccount() async {
    try {
      String token=await SharedPreferenceHandler.getToken();
      var headers = {
        'Accept':"application/json",
        'Authorization': 'Bearer ${token.toString()}'
      };
      var response = await service.
      postService(urlSuffix: "disable-user",
          returnBody: false,headers: headers).then((value) => value);
      return response;
    }catch(ex){
      rethrow;
    }

  }
  uploadImage(imageUrl) async {
    try {
      var response = await service.uploadImage(imageUrl,"update-profile?",false);
      return response;
    }catch(ex){
      rethrow;
    }
  }

  updateProfile(key,value)async
  {

    try {
      String token=await SharedPreferenceHandler.getToken();
      var headers = {
        'Accept':"application/json",
        'Authorization': 'Bearer ${token.toString()}'
      };
      var body={
        key:value,
      };
      var response = await service.
      postService(urlSuffix: "update-profile",
       requestBody: body,
          headers: headers,
          returnBody: false).then((value) => value);
      print(response);
      return response;
    }catch(ex){
      rethrow;
    }
  }
  checkMobileIsExist(mobileNumber) async {

      try {
        var response = await service.
        postService(urlSuffix:"check_mobile?mobile_number=${mobileNumber.toString()}" ,
            returnBody: true).then((value) => value);

       print(response);
        return response;
      }catch(ex){
        rethrow;
      }

  }
 signUp({required String name,required String email,required String mobileNumber}) async {
   try {
     String? tokenFcm = await FirebaseMessaging.instance.getToken();
   print("/////////////////////////////////////////////");
   print (tokenFcm);
     var response = await service.
     postService(urlSuffix: "register?fcm_token=${tokenFcm.toString()}&name=${name.toString()}&email=${email.toString()}&mobile_number=${mobileNumber.toString()}",
         returnBody: false).then((value) => value);
     print(response);
     if(response!=200&&response!=201){
       if(response["errors"]["email"]!=null){
         List v=response["errors"]["email"];
         if(v.contains("The email has already been taken.")){
           return 4;
       }else{
           return 5;
         }
         }else  if(response["errors"]["mobile_number"]!=null){
         List v=response["errors"]["mobile_number"];
         if(v.contains("The mobile number has already been taken.")){
           return 6;
         }else{
           return 7;
         }
       }
     }

     return response;
   }catch(ex){
     rethrow;
   }
 }
  contactUs({required String name,required String email,required String message}) async {
    try {
      String token=await SharedPreferenceHandler.getToken();
      var headers = {
        'Authorization': 'Bearer ${token.toString()}'
      };

      var response = await service.
      postService(headers: headers,urlSuffix: "contact-us?name=${name.toString()}&email=${email.toString()}&message=${message.toString()}", returnBody: false).then((value) => value);

      return response;
    }catch(ex){
      rethrow;
    }
  }


  getUserProfile() async {
    UserModel ? userModel;
    String token=await SharedPreferenceHandler.getToken();
    var headers = {
      'Authorization': 'Bearer ${token.toString()}'
    };
    var response= await ServicesHandler().
    getService(urlSuffix:"profile?",
        headers: headers, ex: true);


      userModel = UserModel.fromJson(response["user"]);


    return userModel;
  }




}