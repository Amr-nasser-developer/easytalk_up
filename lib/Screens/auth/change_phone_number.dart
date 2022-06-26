import 'package:flutter/cupertino.dart' show BorderRadius, BoxDecoration,  BuildContext, Center, Column, Container, EdgeInsets,Image, Key, MainAxisAlignment,  Radius, Row, SingleChildScrollView, State, StatefulWidget, TextEditingController, Widget;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translationchat/Screens/auth/components/textfieldphonenumber.dart';
import 'package:translationchat/Screens/auth/signup.dart';
import 'package:translationchat/constants/colors.dart';
import 'package:translationchat/constants/images.dart';
import 'package:translationchat/provider/userprovider.dart';
import 'package:translationchat/shared/components/back.dart';
import 'package:translationchat/shared/components/buttonglobal.dart';
import 'package:translationchat/shared/components/displaysnackbar.dart';
import 'package:translationchat/shared/components/navigator.dart';
import 'package:translationchat/shared/components/sizedboxglobal.dart';
import 'package:translationchat/shared/components/textfieldglobal.dart';

import 'package:translationchat/shared/text_global.dart';
import 'package:translationchat/utils/sharedprefence.dart';

import 'codenumber.dart';
import 'components/buttonsendemail.dart';



class ChangePhoneNumber extends StatelessWidget {
  // const _SignUpState({Key? key}) : super(key: key);const MyHomePage({Key? key, required this.title}) : super(key: key);
  final focusNode = FocusNode();
  late final TextEditingController controller =TextEditingController();
  @override
  Widget build(BuildContext context) {

    final validationService = Provider.of<UserProvider>(context,listen: false);
    return  SafeArea(
      child: Scaffold(
          body:SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child:   Center(
                  child: Column(children: [
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Row(mainAxisAlignment: MainAxisAlignment.start,children: [
                        Back()
                      ],),
                    ),

                    SizedBox(height: 100,),
                    textGlobalBlackBold16(context: context,text: "تغيير رقم هاتفك"),
                    Padding(padding: EdgeInsets.all(10),child: TextFieldGlobal(focus: false,myFocusNode: focusNode,keyboardType: TextInputType.phone,controller:controller ,hint:"ادخل الرقم",
                      label: darkCyan,widthBorder: 2.0,)),
                    //  Expanded(child: Container()),
                    sizedBoxGlobalHeight40(),
                    GestureDetector(onTap: () async {
                      validationService.mobileNumber=controller.text;

                      var response   = await validationService.sendMobileNumber
    (mobileNumber: controller.text);
    if(response==0) {

      AppNavigator.navigateTo(context,  CodeNumber(route: 1,));

    }else{
    displaySnackBar(context, "يرجي مراجعه رقم التليقون");
    }

                    },child: buttonGlobal(context: context,text: "ارسل"))
                  ],)))),
    );

  }



}