
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHandler {
  static setToken(String token) async {
    try {
      //SharedPreferences.setMockInitialValues({});
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("TOKEN", token);
      print(prefs.getString("TOKEN"));

    } catch (e) {
      print(e.toString());
    }
  }




  static getToken() async {
    try {
      //SharedPreferences.setMockInitialValues({});
      SharedPreferences  prefs = await SharedPreferences.getInstance();

   if(prefs!=null){
     return prefs.getString('TOKEN');
   }else{
     return "null";
   }
    } catch (e) {
      print("get token err :$e");
    }
  }

  static setVerificationId(String verificationId,) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("verificationId", verificationId);
    } catch (e) {
      print(e.toString());
    }
  }

  static setIntro() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("Intro", "Intro");
    } catch (e) {
      print(e.toString());
    }
  }

  static getIntro() async {
    try {
      //SharedPreferences.setMockInitialValues({});
      SharedPreferences  prefs = await SharedPreferences.getInstance();

      if(prefs!=null){
        return prefs.getString('Intro');
      }else{
        return "null";
      }
    } catch (e) {
      print("get token err :$e");
    }
  }

  static getVerificationId() async {
    try {
      //SharedPreferences.setMockInitialValues({});
      SharedPreferences  prefs = await SharedPreferences.getInstance();

      if(prefs!=null){
        return prefs.getString('verificationId');
      }else{
        return "null";
      }
    } catch (e) {
      print("get token err :$e");
    }
  }

}