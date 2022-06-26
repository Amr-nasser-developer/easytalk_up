import 'package:flutter/cupertino.dart' show   BuildContext, Center, Column, Container, EdgeInsets,Image, Key, MainAxisAlignment,  Row, SingleChildScrollView, State, StatefulWidget, TextEditingController, Widget;
import 'package:flutter/material.dart';
import 'package:translationchat/constants/colors.dart';
import 'package:translationchat/constants/images.dart';
import 'package:translationchat/shared/components/back.dart';
import 'package:translationchat/shared/components/sizedboxglobal.dart';
import 'package:translationchat/shared/text_global.dart';





class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);
  @override
  AboutUsState createState() => AboutUsState ();
}

class AboutUsState extends State<AboutUs> {
  // const _SignUpState({Key? key}) : super(key: key);const MyHomePage({Key? key, required this.title}) : super(key: key);

  late final TextEditingController controller =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        backgroundColor: white,
          body:SingleChildScrollView(
              padding: const EdgeInsets.all(10),

                child: Center(
                    child: Column(children: [
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Row(mainAxisAlignment: MainAxisAlignment.start,children: [
                          Back()
                        ],),
                      ),

                      Container(
                        padding:const EdgeInsets.all(20),
                        width: MediaQuery.of(context).size.width,

                        decoration: BoxDecoration(
                          color: white,
                          image: const DecorationImage(image: ExactAssetImage(map), fit: BoxFit.cover,),
                        ),child: Column(children: [
                        Row(mainAxisAlignment: MainAxisAlignment.end,children: [
                          textGlobalBlack20(context: context,text: "عن التطبيق"),
                        ],),

                        sizedBoxGlobalHeight20(),
                        Image.asset(logo)
                      ],),
                      ),


textGlobalBlackBold13(context: context,text: "تطبيق يتيح لك الترجمه الفوريه للجميع المحادثات "),
textGlobalBlackBold13(context: context,text: "في  جميع انحاء العالم"),    sizedBoxGlobalHeight20(),
Image.asset(logoCompany),
sizedBoxGlobalHeight20(),
Padding(padding: const EdgeInsets.only(left: 10,right: 10),child: Divider(color: darkCyan,thickness: 2,)),
                      sizedBoxGlobalHeight20(),
                      Row(mainAxisAlignment: MainAxisAlignment.center,children: [
  Image.asset(logoFace),
  sizedBoxGlobalWidth10(),
  Image.asset(logoTwitter),
  sizedBoxGlobalWidth10(),
  Image.asset(logoIns)
],)

                      //GlobalTextField(controller: controller, hint: hint)

                    ],)),
              )));


  }



}