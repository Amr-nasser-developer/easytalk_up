import 'package:flutter/cupertino.dart' show   BuildContext, Center, Column, Container, Key, MainAxisAlignment, State, StatefulWidget, TextEditingController, Widget;
import 'package:flutter/material.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:translationchat/Screens/room/roomscreen.dart';
import 'package:translationchat/constants/colors.dart';
import 'package:translationchat/constants/images.dart';
import 'package:translationchat/provider/userprovider.dart';
import 'package:translationchat/shared/components/buttonglobal.dart';
import 'package:translationchat/shared/components/displaysnackbar.dart';
import 'package:translationchat/shared/components/navigator.dart';
import 'package:translationchat/shared/components/sizedboxglobal.dart';
import 'package:translationchat/shared/components/textfieldglobal.dart';
import 'package:translationchat/shared/text_global.dart';

import 'login.dart';


class SucCode extends StatefulWidget {
  String? mobileNumber;
   SucCode({Key? key,required mobileNumber}) : super(key: key);



  @override
  SucCodeState  createState() => SucCodeState ();
}

class SucCodeState extends State<SucCode> {


  TextEditingController controller = TextEditingController(text: "");


  @override
  Widget build(BuildContext context) {
    final validationService = Provider.of<UserProvider>(context);
    return  SafeArea(
      child: Scaffold(
          body:

          Container(
            color: Colors.black12,
            child: Center(
                child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,children: [
                 Padding(
padding: const EdgeInsets.all(20),
                   child: Container(
                     width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                color: white,
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),child: Column(children: [
                    sizedBoxGlobalHeight30(),
                     Image.asset(iconActive),
                     textGlobalBlackBold16(context: context,text: "تم التحقق   من الرمز بالنجاح"),
                     sizedBoxGlobalHeight30(),
                    // textGlobalBlackBold13(context: context,text: "تم التاكيد علي حساب الجديد بالتطبيق"),
                     textGlobalBlackBold16(context: context,text: " شكرا .."),
                     sizedBoxGlobalHeight30(),
                     GestureDetector(onTap: () async {
//validationService.getMobileToken();
                     goToAction();

                     },child: buttonGlobalText(context: context,text: "موافق")),
                     sizedBoxGlobalHeight30(),

                     TweenAnimationBuilder<Duration>(

                         duration: Duration(seconds:3 ),
                         tween: Tween(begin: Duration(seconds:3
                         ), end:Duration.zero,




                         ),
                         onEnd: () async {
                           goToAction();

/*Navigator.push(
                                       context,
                                       MaterialPageRoute(
                                         builder: (context) => NavigationBar(0),
                                       ));*/

                           print('Timer ended');
                         },
                         builder: (BuildContext ?context, Duration ?value, Widget ?child) {
                           //    final days=value.inDays;

                           return Align(
                             alignment: Alignment.center,
                             child:  Text("${value!.inSeconds%60%60}",style: GoogleFonts.tajawal(
                               color: Colors.black38,
                               //fontWeight: FontWeight.bold,

                               fontSize:28 ,
                             )),
                           );
                         })
                   ],),),
                 ),




                ],)),
          )),
    );

  }
  goToAction() async {
    final validationService = Provider.of<UserProvider>(context,listen: false);
//Position s=await   _determinePosition();
//print(".vvvvvvvvv");
//print(s.timestamp);
    var x     =     await validationService.getToken(validationService.mobileNumber);
    if(x==0){
      await validationService.getUserProfile();
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => RoomScreen(),), (route) => false);
    }else{
      displaySnackBar(context, "حدث خطا ما");
    }
  }

}

