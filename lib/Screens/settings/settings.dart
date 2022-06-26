import 'package:flutter/cupertino.dart' show   BuildContext, Center, Column, Container, EdgeInsets,Image, Key, MainAxisAlignment,  Row, SingleChildScrollView, State, StatefulWidget, TextEditingController, Widget;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translationchat/Screens/about_us/aboutus.dart';
import 'package:translationchat/Screens/auth/change_phone_number.dart';
import 'package:translationchat/Screens/auth/login.dart';
import 'package:translationchat/Screens/information/information.dart';
import 'package:translationchat/provider/userprovider.dart';
import 'package:translationchat/shared/components/back.dart';
import 'package:translationchat/shared/components/bottomsheetglobal.dart';
import 'package:translationchat/shared/components/buttonglobal.dart';
import 'package:translationchat/shared/components/navigator.dart';
import 'package:translationchat/shared/components/sizedboxglobal.dart';
import 'package:translationchat/shared/text_global.dart';



class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);
  @override
  SettingsState createState() => SettingsState ();
}

class SettingsState extends State<Settings> {
  // const _SignUpState({Key? key}) : super(key: key);const MyHomePage({Key? key, required this.title}) : super(key: key);

  late final TextEditingController controller =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
          body:SingleChildScrollView(


                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Center(

                      child: Column(children: [
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Row(mainAxisAlignment: MainAxisAlignment.start,children: [
                            Back()
                          ],),
                        ),

                        sizedBoxGlobalHeight20(),
                        Padding(
                         padding: const EdgeInsets.all(20),
                          child: Row(mainAxisAlignment: MainAxisAlignment.end,children: [
                           sizedBoxGlobalWidth20(), textGlobalBlack20(context: context,text: "الاعدادت")
                          ],),
                        )  ,
                        sizedBoxGlobalHeight20(),

                        Image.asset("assests/ic_launcher.png",height: 150,)
                        ,
                        InkWell(onTap: (){
                          AppNavigator.navigateTo(context, Information(k: "privacy", title: "الخصوصيه"));
                        },child: content(context: context,text: "الخصوصيه",iconData: Icons.lock)),

                      InkWell(onTap: (){
                        AppNavigator.navigateTo(context, ChangePhoneNumber());
                      },child:  content(context: context,text: "تغيير رقم هاتف المحمول",iconData: Icons.exit_to_app),
                      ), InkWell(onTap: (){
                          bottomSheetGlobadl(context: context, body: const DeleteAccount(), height: 200.0);
                        },child: content(context: context,text: "حذف حسابي",iconData: Icons.delete)),
                      // content(context: context,text: "طلب معلومات الحساب",iconData: Icons.note),
                        InkWell(onTap: (){
                          AppNavigator.navigateTo(context, AboutUs());
                        },child:
                        content(context: context,text: "عن التطبيق",iconData: Icons.phone_android_sharp)),
                        InkWell(onTap: (){
                          AppNavigator.navigateTo(context, Information(k: "about_us", title: "من نحن"));
                        },child: content(context: context,text: "من نحن",iconData: Icons.error_outline)),













                        //GlobalTextField(controller: controller, hint: hint)

                      ],)),
                ),
              )),
    );

  }



}

Widget content({required BuildContext context,text,iconData}){
return  Padding(padding: const EdgeInsets.only(left: 30,right: 30,top: 15,bottom: 15),child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
    Icon(iconData),
    textGlobalBlackBold13(context: context,text:text)

  ],),);
}


class DeleteAccount extends StatelessWidget {
  const DeleteAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final validationService = Provider.of<UserProvider>(context,listen: false);
    return Column(children: [

  textGlobalBlackNormal16(context: context,text: "هل انت متاكد من هذه الخطوه؟"),
      SizedBox(height: 20,),
      GestureDetector(onTap: () async {
       var response=await validationService.disableAccount();
       if(response==200) {
         final pref = await SharedPreferences.getInstance();
         await pref.clear();
         Navigator.pushAndRemoveUntil(
             context, MaterialPageRoute(builder: (context) => Login(),), (
             route) => false);
       }else{
         Navigator.of(context).pop();
       }
        },child: buttonGlobal(context: context,text: "تاكيد")),
      SizedBox(height: 20,),
      GestureDetector(onTap: () async {
Navigator.of(context).pop();
      },child: buttonGlobal(context: context,text: "الغاء"))



    ],);
  }



}
sheetUpdate(){




}