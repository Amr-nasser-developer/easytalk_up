import 'package:flutter/cupertino.dart' show BorderRadius, BoxDecoration,  BuildContext, Center, Column, Container, EdgeInsets,Image, Key, MainAxisAlignment,  Radius, Row, SingleChildScrollView, State, StatefulWidget, TextEditingController, Widget;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translationchat/Screens/auth/components/textfieldphonenumber.dart';
import 'package:translationchat/Screens/auth/signup.dart';
import 'package:translationchat/Screens/chat/chat_screen_copy.dart';
import 'package:translationchat/Screens/information/information.dart';
import 'package:translationchat/constants/colors.dart';
import 'package:translationchat/constants/images.dart';
import 'package:translationchat/provider/userprovider.dart';
import 'package:translationchat/shared/components/buttonglobal.dart';
import 'package:translationchat/shared/components/displaysnackbar.dart';
import 'package:translationchat/shared/components/navigator.dart';
import 'package:translationchat/shared/components/sizedboxglobal.dart';
import 'package:translationchat/shared/components/textfieldglobal.dart';

import 'package:translationchat/shared/text_global.dart';
import 'package:translationchat/utils/sharedprefence.dart';

import 'codenumber.dart';
import 'components/buttonsendemail.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  LoginState createState() => LoginState ();
}

class LoginState extends State<Login> {
  // const _SignUpState({Key? key}) : super(key: key);const MyHomePage({Key? key, required this.title}) : super(key: key);
bool  checkedValue=false;
  late final TextEditingController controller =TextEditingController();
  @override
  Widget build(BuildContext context) {

     final validationService = Provider.of<UserProvider>(context);
    return
       WillPopScope(
         onWillPop: () async {
           focusNode.unfocus();
         return true;
           },
         child: Scaffold(
            body:SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                child:   Center(
                    child: Column(children: [

                      sizedBoxGlobalHeight80(),
                    textGlobalBlackBold16(context: context,text: "اهلا بك"),
                      sizedBoxGlobalHeight20(),
                      Image.asset(logoLogin,height: 250,),
                      Container(
                        padding: const EdgeInsets.only(left: 30,right: 30),
                        child: Column(children: [
                      //    TextFieldGlobal(controller:controller ,hint: "الاسم باللغه العربيه كاملا",label: darkCyan,widthBorder: 2.0,),
                        //  TextFieldGlobal(controller:controller ,hint: "البريد الالكتروني",label: darkCyan,widthBorder: 2.0,),
                          textFieldPhoneNumber(controller,context),
                          //sizedBoxGlobalHeight10(),
                          //emailSend(context,(){}),
                          //sizedBoxGlobalHeight10(),


                          /*phoneSend(context,() async {




                          }),*/
                       //   Divider(color: darkCyan,thickness: 1,),

                          InkWell(onTap: () async {
                           if(checkedValue==true) {


                             validationService.mobileNumber = controller.text;

                             var result = await validationService.mobileIsExist(
                                 controller.text);
                             print(result);
                             if (result[0] == "success") {
                          print(result);
                               var response = validationService.sendMobileNumber
                                 (mobileNumber: controller.text);
                               if (response == 0) {
                                 AppNavigator.navigateTo(
                                     context, CodeNumber(route: 0,));
                               } else {
                                 displaySnackBar(
                                     context, "يرجي مراجعه رقم التليقون");
                               }
                             }else{
                               displaySnackBar(
                                   context, "يرجي مراجعه رقم التليقون");

                             }

                           }else{
                             displaySnackBar(context,"يرجي الموافقه علي الشروط والاحكام");
                           }
                          },child: buttonGlobal(context: context,text: "تسجيل الدخول "))
                       ,
                          SizedBox(height: 20,),


                        ],),


                      ),











                  /*    GestureDetector(
                      onTap: (){

                    var response   = validationService.sendMobileNumber(mobileNumber: controller.text);
                      if(response==0) {
                        AppNavigator.navigateTo(context, const CodeNumber());
                      }else{
                        displaySnackBar(context, "يرجي مراجعه رقم التليقون");
                      }
                      },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30,right: 30),
                          child: Container(decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(20)),
                              color: darkCyan
                          ),child: Padding(
                            padding:const  EdgeInsets.all(10)         ,
                            child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [

                              textGlobalWhiteBold14(context: context,text: "  تسجيل دخول"),

                            ],),
                          )),
                        ),
                      ),*/


                        InkWell(
                          onTap: (){
                            AppNavigator.navigateTo(context, Information(k: "privacy", title: "الخصوصيه"));

                          },
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: CheckboxListTile(
                              title: InkWell(
                                onTap: (){
                                  AppNavigator.navigateTo(context, Information(k: "privacy", title: "الخصوصيه"));

                                },child: textGlobalblueBold13(context: context,text: "يرجي الموافقه علي الشروط والاحكام"),
                              ),
                                value: checkedValue,
                              onChanged: (newValue) {
                                setState(() {
                                  checkedValue = newValue!;
                                });
                              },
                              controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                            ),
                          ),
                        )

                      ,
                      sizedBoxGlobalHeight10(),
           GestureDetector(onTap: (){
             AppNavigator.navigateTo(context, const SignUp());
           },child:   Row(mainAxisAlignment: MainAxisAlignment.center,children: [
             textGlobalblueBold13(context: context,text: "تسجيل حساب جديد   "),
             textGlobalGreyBold13(context: context,text: "لا تمتلك حساب بالفعل ؟   "),

           ],),
             ),
             ],)))),
       );


  }



}