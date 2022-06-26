import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translationchat/constants/colors.dart';
import 'package:translationchat/provider/userprovider.dart';
import 'package:translationchat/utils/sharedprefence.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: back12s,
      body: Center(child: Column(children: [
        Image.asset("assests/Group988.png",),
        Image.asset("assests/Group 995.png"),
      ],)
      ),
    );
  }
}
class Init {
  Init._();
  static final instance = Init._();

  Future initialize(BuildContext context) async {

    final validationServiceUser = Provider.of<UserProvider>(context,listen: false);
    //await SharedPreferenceHandler.setToken("Bearer 13|kLvxplZXW2DsKbNQ9qcaUsLtY6SxHRW7iMkj4N8F");
    String? token=await SharedPreferenceHandler.getToken();
    String ? intro=await SharedPreferenceHandler.getIntro();
    if(token!=null){
      validationServiceUser.loginOrNot=true;
      validationServiceUser.getUserProfile();
      validationServiceUser.userIsOLine();
      print("%%%%%%%%%%%");
      print(validationServiceUser.listUserProfileGeneralState.hasData);

    }else{

      validationServiceUser.loginOrNot=false;
      if(intro==null){
        print("fffff");
        validationServiceUser.introScreen=true;
      }else{
print("ggggggg");
        validationServiceUser.introScreen=false;
      }
    }
    await Future.delayed(const Duration(seconds: 1));
  }
}