import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:translationchat/Screens/auth/login.dart';
import 'package:translationchat/Screens/auth/updateprofile.dart';

import 'package:translationchat/Screens/contactus/contactus.dart';
import 'package:translationchat/Screens/qr_code/checknumberphone.dart';
import 'package:translationchat/Screens/settings/settings.dart';
import 'package:translationchat/constants/colors.dart';
import 'package:translationchat/provider/userprovider.dart';
import 'package:translationchat/shared/components/sizedboxglobal.dart';
import 'package:translationchat/shared/text_global.dart';
import 'package:translationchat/shared/widgets/circleavatatimage.dart';
import 'package:url_launcher/url_launcher.dart';

import 'navigator.dart';

class navigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(


        child: Container(
height: double.maxFinite,
          color: cyan,
          child: ListView(

            children: <Widget>[
              sizedBoxGlobalHeight10(),

              createDrawerHeader(context),
              sizedBoxGlobalHeight20(),
createImageItem(context: context, onTap: (){
  AppNavigator.navigateTo(context,const UpdateProfile ());
}),
              createDrawerBodyItem(
               context: context,
                icon: Icons.vpn_key_sharp,
                text: 'الحساب',
                onTap: () {
                  AppNavigator.navigateTo(context,const UpdateProfile ());
                }

              ),
              createDrawerBodyItem(
                context: context,
                  icon: Icons.add_ic_call_rounded,
                text: 'اتصل بنا',
                onTap: (){
                  AppNavigator.navigateTo(context,const ContactUs ());
                }

              ),

              createDrawerBodyItem(
context: context,
                icon: Icons.settings,
                text: 'الضبط',
                onTap: (){
                  AppNavigator.navigateTo(context,const Settings());
                }

              ),
              Padding(padding: EdgeInsets.only(left: 20,right: 20),child: Divider(thickness: 2,color: darkCyan,)),

              GestureDetector(
               onTap: (){

               },
                child: createDrawerBodyItem(
                    context: context,
                    icon: Icons.person_add_alt_1_sharp,
                    text: 'دعوه صديق',
                    onTap: (){
                      AppNavigator.navigateTo(context,const CheckNumberPhone());
                    }

                ),
              ),


              GestureDetector(
                onTap: (){

                },
                child: createDrawerBodyItem(
                    context: context,
                    icon: Icons.share,
                    text: 'مشاركه التطبيق ',
                    onTap: (){
                      _launchURL();
                    }

                ),
              ),

              // GestureDetector(
              //   onTap: (){
              //
              //   },
              //   child: createDrawerBodyItem(
              //       context: context,
              //       icon: Icons.share,
              //       text: 'مشاركه التطبيق عبر الايفون   ',
              //       onTap: (){
              //
              //         Share.share("https://apps.apple.com/eg/app/easytalk-%D8%A7%D9%8A%D8%B2%D9%8A-%D8%AA%D9%88%D9%83/id1605351891");
              //
              //       }
              //
              //   ),
              // ),
            SizedBox(height: 10,),
            SizedBox(
              height: 250,
              child: SfBarcodeGenerator(
           barColor: Colors.white,
                value:"http://easytalkapp.dnbscy.com/",
                symbology: QRCode(),
                showValue: false,
              ),
            ),


              createDrawerBodyItem(
                  context: context,
                  icon: Icons.exit_to_app,
                  text: 'تسجيل الخروج',
                  onTap: () async {
                    final pref = await SharedPreferences.getInstance();
                  await pref.remove("TOKEN");
                    await pref.clear();
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Login(),), (route) => false);

                  }

              ),sizedBoxGlobalHeight20(),

            ],
          ),
        ),

    );
  }
  var _url = 'http://easytalkapp.dnbscy.com/';
  void _launchURL() async =>
      await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
}
Widget createDrawerBodyItem(
    {required BuildContext context,required IconData icon, required String text, required GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Icon(icon,color: Colors.white,),
        Padding(
          padding: EdgeInsets.only(left: 15.0),
          child: textGlobalWhiteBold14(context: context,text: text),
        ),
        sizedBoxGlobalWidth20(),
      ],
    ),
    onTap: onTap,
  );
}
Widget createImageItem(
    {required BuildContext context, required GestureTapCallback onTap}) {
  final validationService2 = Provider.of<UserProvider>(
      context, listen: false);
  if(validationService2.listUserProfileGeneralState.hasData==true){
  return ListTile(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
       circleAvatarImage(validationService2.listUserProfileGeneralState.data!.imagePath,false),
        Padding(
          padding:const EdgeInsets.only(left: 25.0),
          child: textGlobalWhiteBold14(context: context,text: validationService2.listUserProfileGeneralState.data!.name),
        ),
        sizedBoxGlobalWidth20(),
      ],
    ),
    onTap: onTap,
  );
}else{
    return Text("");
  }
}
Widget createDrawerHeader(BuildContext context) {
  return

    ListTile   (
        title: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [


                Icon(Icons.arrow_back_ios,color: white,size: 30,),

                textGlobalWhiteBold28(context: context,text: "الاعدادت"),
          sizedBoxGlobalWidth20(),

        ]),
      );
}

