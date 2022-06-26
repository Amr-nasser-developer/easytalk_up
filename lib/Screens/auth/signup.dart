import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart' show BorderRadius, BoxDecoration, BoxFit, BuildContext, Center, Column, Container, DecorationImage, EdgeInsets, ExactAssetImage, Expanded, Key, MainAxisAlignment, MediaQuery, Radius, Row, SingleChildScrollView, State, StatefulWidget, TextEditingController, Widget;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translationchat/Screens/auth/components/textfieldphonenumber.dart';
import 'package:translationchat/Screens/auth/login.dart';
import 'package:translationchat/constants/colors.dart';
import 'package:translationchat/constants/images.dart';
import 'package:translationchat/provider/userprovider.dart';
import 'package:translationchat/shared/components/back.dart';
import 'package:translationchat/shared/components/displaysnackBar.dart';
import 'package:translationchat/shared/components/navigator.dart';
import 'package:translationchat/shared/components/sizedboxglobal.dart';
import 'package:translationchat/shared/components/textfieldglobal.dart';

import 'package:translationchat/shared/text_global.dart';
import 'codenumber.dart';
import 'components/buttonsendemail.dart';

class SignUp extends StatefulWidget {

  const SignUp({Key? key}) : super(key: key);
  @override
  SignUpState createState() => SignUpState ();
}

class SignUpState extends State<SignUp> {
  // const _SignUpState({Key? key}) : super(key: key);const MyHomePage({Key? key, required this.title}) : super(key: key);
  final focusNode = FocusNode();
  final focusNode2 = FocusNode();
  final focusNode3 = FocusNode();
  late final TextEditingController nameController =TextEditingController();
  late final TextEditingController emailController =TextEditingController();
  late final TextEditingController mobileNumberController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    final validationService = Provider.of<UserProvider>(context);
    return   WillPopScope(
      onWillPop: () async {
        focusNode3.unfocus();
        focusNode.unfocus();
        focusNode2.unfocus();
        return true;
      },
      child: Scaffold(
          body:SingleChildScrollView(
              padding: const EdgeInsets.all(0),
              child:   GestureDetector(
                onTap: (){
                  focusNode3.unfocus();
                  focusNode.unfocus();
                  focusNode2.unfocus();
              },
                child: Center(
                    child: Column(children: [
                      Container(

                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        decoration: BoxDecoration(
                          color: lightCyan,
                          image: const DecorationImage(image: ExactAssetImage(map2), fit: BoxFit.cover,),
                        ),child: Column(children: [
                        SizedBox(height: 20,),
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Row(mainAxisAlignment: MainAxisAlignment.start,children: [
                            Back()
                          ],),
                        ),
                        Expanded(child: Container()),
                        textGlobalWhiteBold18(context: context,text: "مرحبا بك"),
                        textGlobalWhiteBold14(context: context,text: "تسجيل حساب جديد "),
                        Expanded(child: Container()),
                      ],),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 30,right: 30),
                        child: Column(children: [


                          TextFieldGlobal(myFocusNode: focusNode,focus: true,keyboardType: TextInputType.text,controller:nameController ,hint: "الاسم باللغه العربيه كاملا",label: darkCyan,widthBorder: 2.0,),
                          TextFieldGlobal(myFocusNode: focusNode3,focus: true,keyboardType: TextInputType.text,controller:emailController ,hint: "البريد الالكتروني",label: darkCyan,widthBorder: 2.0,),
                          Container(decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),

                          ),child: Padding(
                            padding:const EdgeInsets.all(10)         ,
                            child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [

                              //   SizedBox(width: 20,),

                              Flexible(child:  TextFieldGlobal(myFocusNode: focusNode2,focus: false,keyboardType: TextInputType.number,label: Colors.black12,
                                  controller:mobileNumberController ,hint: "5xxxxxxx",widthBorder:2.0)),
                              Icon(Icons.keyboard_arrow_down_sharp,color: black,),
                              sizedBoxGlobalWidth10(),
                              GestureDetector(onTap: (){
                                showCountryPicker(

                                  context: context,
                                  showPhoneCode: true, // optional. Shows phone code before the country name.
                                  countryListTheme: const CountryListThemeData(
                                    // Optional. Sets the border radius for the bottomsheet.
                                      inputDecoration: InputDecoration(
                                        labelText: 'Search',
                                        hintText: 'Start typing to search',
                                        prefixIcon: const Icon(Icons.search),

                                      ),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10.0),
                                        topRight: Radius.circular(10.0),
                                      )),
                                  onSelect: (Country country) {
                                    validationService.countryCode=country.phoneCode;
                                    validationService.countryName=country.countryCode;
                                    validationService.notifyListeners();
                                  },
                                );
                                //  counteryPicker(context);
                              },child: /*const  CircleAvatar
        (radius: 10,
          backgroundImage:
          NetworkImage("https://firebasestorage.googleapis.com/v0/b/okhtub-5a9d2.appspot.com/o/flags%2F149.png?alt=media&token=4f1cd246-f980-4957-942c-abd6190e3496")*/
                              textGlobalBlackBold16(context: context,text: validationService.countryName)
                              )
                            ],),
                          )),

                          // textFieldPhoneNumber(mobileNumberController,context),
                          // sizedBoxGlobalHeight10(),
                          // emailSend(context,(){}),
                          sizedBoxGlobalHeight10(),
                          phoneSend(context,() async {
                            validationService.mobileNumber=mobileNumberController.text;
                            var response  =await validationService.signUp(name: nameController.text, email: emailController.text, mobileNumber: mobileNumberController.text);
                            if(response==0){
                              displaySnackBar(context, "تم التسجيل");

                              validationService.sendMobileNumber(mobileNumber:
                              mobileNumberController.text.trim());
                              AppNavigator.navigateOfAll(context, CodeNumber(route: 0,));
                            }else{
                              switch(response){
                                case 4:
                                  displaySnackBar(context, "هذا الايميل مسجل من قبل");
                                  break;
                                case 5:
                                  displaySnackBar(context, "يرجي مراجعه الايميل");
                                  break;
                                case 7:
                                  displaySnackBar(context, "يرجي مراجعه رقم التليفون");
                                  break;
                                case 6:
                                  displaySnackBar(context, "رقم التليفون مسجل من قبل");
                                  break;
                                  default:
                                    displaySnackBar(context, "يرجي مراجعه الداتا");
                                    break;

                              }

                            }
                          }),
                          Divider(color: darkCyan,thickness: 5,),
                        ],),


                      ),











                      /* GestureDetector(
          onTap: (){
            AppNavigator.navigateTo(context,const CodeNumber());
          },
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Container(decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: darkCyan
            ),child: Padding(
                padding:const  EdgeInsets.all(10)         ,
                child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [

                  textGlobalWhiteBold14(context: context,text: "تسجيل"),

                ],),
            )),
          ),
        ),textGlobalGreyBold13(context: context,text: "تمتلك حساب بالفعل سجل .... الدخول  ")*/

                      //GlobalTextField(controller: controller, hint: hint)

                    ],)),
              ))),
    );

  }



}