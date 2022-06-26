

import 'package:flutter/cupertino.dart';
import 'package:translationchat/constants/colors.dart';
import 'package:translationchat/shared/text_global.dart';

Widget buttonGlobal({required BuildContext context,text,expanded}){
return  Padding(
    padding: const EdgeInsets.only(left: 20,right: 20),
    child: Container(decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: darkCyan
    ),child: Padding(
      padding:const  EdgeInsets.all(10)         ,
      child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [

      textGlobalWhiteBold12(context: context,text:text),

      ],),
    )),
  );
}
Widget buttonGlobalText({required BuildContext context,text}){
  return  Padding(
    padding: const EdgeInsets.only(left: 30,right: 30),
    child: Container(decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: darkCyan
    ),child: Padding(
      padding:const  EdgeInsets.only(left: 40,right: 40,top: 5,bottom: 5)         ,
      child:

        textGlobalWhiteBold14(context: context,text:text),


    )),
  );
}