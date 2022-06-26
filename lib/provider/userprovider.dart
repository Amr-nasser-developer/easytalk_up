import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:translationchat/data/userdata.dart';

import 'package:translationchat/models/providergeneralstate.dart';
import 'package:translationchat/models/usermodel.dart';


class UserProvider extends ChangeNotifier {
  late ProviderGeneralState<UserModel> listUserProfileGeneralState;
  late ProviderGeneralState<String> listUserProfileInformationState;

  UserData userData=UserData();
  String? mobileNumber;
  var countryCode="966";
  var countryName="SA";
  late bool loginOrNot;
  late bool introScreen;
  getToken(mobileNumber) {
    try {
   final response  = userData.getToken(mobileNumber);
   return response;
    } catch (ex) {
      return 1;
    }
  }



  checkCode(smsCode) async {
    try {
      var value = await userData.checkCode(smsCode: smsCode);
      print("/////////////////");
      print(value);
      return value;
    } catch (ex) {
      rethrow;
    }
  }

  getMobileToken()
  async{
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      print("/////////////////////////////////////////////");
      print (token);
      return token;

    }catch(ex){
rethrow;
    }


  }

updateNumber(){
  try {
    return userData.updateNumber(mobileNumber);
  } catch (ex) {
    rethrow;
  }
}
  disableAccount(){
    try {
      return userData.disableAccount();
    } catch (ex) {
      rethrow;
    }
  }



  sendMobileNumber({required String mobileNumber}) {
    try {
      if (validateMobile(mobileNumber)) {
        print("///////////");
        userData.getMobileNumber(mobileNumber: mobileNumber,countryCode:countryCode );
        return 0;
      } else {
        return 1;
      }
    } catch (ex) {
      rethrow;
    }
  }

  getInformation(key) async {
    try {
      String x;
      setWaiting(1);
      x= await userData.getInformation(key);
      listUserProfileInformationState =
          ProviderGeneralState(data: x, hasData: true);
      notifyListeners();
    }catch(ex){
      rethrow;
    }
  }

  updateProfile(key,value) {
    try {
     return userData.updateProfile(key, value);
    } catch (ex) {
      rethrow;
    }
  }
  mobileIsExist(mobileNumber) {
    try {
      return userData.checkMobileIsExist(mobileNumber);
    } catch (ex) {
      rethrow;
    }
  }

  logout() {
    try {
      userData.logOut();
    } catch (ex) {
      rethrow;
    }
  }


  signUp(
      {required String name, required String email, required String mobileNumber}) async {
    try {

email.trim();
if(validateEmail(email.replaceAll(" ", ""))&&validateMobile(mobileNumber.replaceAll(" ", ""))) {
 var response=await userData.signUp(
      name: name, email: email.replaceAll(' ', ''), mobileNumber: mobileNumber);
if(response==200||response==201) {
  return 0;
}else{
  return response;
}
}else{
  return 1;
}
    } catch (ex) {
      rethrow;
    }
  }




  File? mainImage;
  Future  uploadImage(bool cameraORGallery) async {
    final picker = ImagePicker();
    ImagePicker _picker = ImagePicker();
    final PickedFile? file = await _picker.getImage(
        source: cameraORGallery == true ? ImageSource.camera : ImageSource.gallery,
        imageQuality: 50);
    File tmpFile = File(file!.path);
    print(tmpFile.path);
    mainImage = tmpFile;
   var response = await userData.uploadImage(mainImage);
if(response==200){
  getUserProfile();
}
    notifyListeners();
  }
  contactUS(
      {required String name, required String email, required String message}) {
    try {

      email.trim();
      if(validateEmail(email.replaceAll(" ", ""))) {
        userData.contactUs(
            name: name, email: email.replaceAll(' ', ''), message: message);
        return 0;
      }else{
        return 1;
      }
    } catch (ex) {
      rethrow;
    }
  }




  validateEmail(String value) {
    value=value.trim().toString();
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return false;
    } else if (!regExp.hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }

  validateMobile(String value) {
    String pattern = r'(^[0-9]*$)';
    RegExp regExp = RegExp(pattern);
    if (value
        .replaceAll(" ", "")
        .isEmpty) {
      return false;

    } else if (!regExp.hasMatch(value.replaceAll(" ", ""))) {
      return false;
    }
    return true;
  }

  getUserProfile() async {
    try {
      UserModel ?userModel;
      setWaiting(0);
     userModel = await userData.getUserProfile();
      listUserProfileGeneralState =
          ProviderGeneralState(data: userModel, hasData: true);
      notifyListeners();
    } catch (ex) {
      rethrow;
    }
  }
  userIsOLine(){
    try {
      return userData.userIsOLine();
    }catch(ex){
      rethrow;
    }
  }
  userIsOffLine(){
    try {
      return userData.userIsOffline();
    }catch(ex){
      rethrow;
    }

  }

  void setWaiting(index) {
    switch (index) {
      case 0:
        listUserProfileGeneralState = ProviderGeneralState(waiting: true);
        break;
      case 1:
        listUserProfileInformationState = ProviderGeneralState(waiting: true);
        break;
    }
  }


}
