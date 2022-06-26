import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:translationchat/constants/colors.dart';

Widget textGlobal({text,required BuildContext context,double? fontSize,required Color color,required bool bold ,lines }){
  return  AutoSizeText(text,
    textAlign: TextAlign.right,
     style: GoogleFonts.cairo(
      color: color,

      fontWeight: bold==true? FontWeight.bold:FontWeight.normal,
      fontSize: fontSize,


    ),maxLines:lines==null? 1:lines
    ,
  );
}





textGlobalWhiteBold20({required BuildContext context,text}){
  return textGlobal(text:text ,context: context,fontSize: 20.0,color:Colors.white,bold: true);
}
textGlobalYellowBold24({required BuildContext context,text}){
  return textGlobal(text:text ,context: context,fontSize: 20.0,color:Colors.yellow,bold: true);
}
textGlobalWhiteBold24({required BuildContext context,text}){
  return textGlobal(text:text ,context: context,fontSize: 20.0,color:Colors.white,bold: true);
}
textGlobalWhiteBold28({required BuildContext context,text}){
  return textGlobal(text:text ,context: context,fontSize: 26.0,color:Colors.white,bold: true);
}
textGlobalBlack20({required BuildContext context,text}){
  return textGlobal(text:text ,context: context,fontSize: 20.0,color:black,bold: true);
}

textGlobalOrangeBold14({required BuildContext context,text}){
  return textGlobal(text:text ,context: context,fontSize: 14.0,color:Colors.orange.shade700,bold: true);
}
textGlobalNormal14({required BuildContext context,text}){
  return textGlobal(text:text ,context: context,fontSize: 14.0,color:Colors.orange.shade700,bold: false);
}
textGlobalNormalWhite14({required BuildContext context,text}){
  return textGlobal(text:text ,context: context,fontSize: 12.0,color:Colors.white,bold: false);
}
textGlobalWhiteBold14({required BuildContext context,text}){
  return textGlobal(text:text ,context: context,fontSize: 14.0,color:Colors.white,bold: true,lines: 20);
}
textGlobalWhiteBold18({required BuildContext context,text}){
  return textGlobal(text:text ,context: context,fontSize: 18.0,color:Colors.white,bold: true);
}
textGlobalBlackBold14({required BuildContext context,text}){
  return textGlobal(text:text ,context: context,fontSize: 14.0,color:Colors.black,bold: true);
}
textGlobalWhiteBold12({required BuildContext context,text}){
  return textGlobal(text:text ,context: context,fontSize: 12.0,color:Colors.white,bold: true);
}
textGlobalLightCyanNormal12({required BuildContext context,text}){
  return textGlobal(text:text ,context: context,fontSize: 16.0,color:lightCyan,bold: true);
}
textGlobalOrangeBold17({required BuildContext context,text}){
  return textGlobal(text:text ,context: context,fontSize: 17.0,color:Colors.deepOrange,bold: true);
}
textGlobalOrangeBold20({required BuildContext context,text}){
  return textGlobal(text:text ,context: context,fontSize: 20.0,color:Colors.deepOrange,bold: true);
}

textGlobalWhiteOld25({required BuildContext context,text}){
  return textGlobal(text:text ,context:
  context,fontSize: 25.0,color:white2,bold: true);
}
textGlobalBlackBold16({required BuildContext context,text}){
  return textGlobal(text:text ,context: context,fontSize: 16.0,color:black,bold: true);
}

textGlobalGreyBold16({required BuildContext context,text}){
  return textGlobal(text:text ,context: context,fontSize: 16.0,color:Colors.grey,bold: true,lines: 2);
}
textGlobalGreyNormal16({required BuildContext context,text}){
  return textGlobal(text:text ,context: context,fontSize: 16.0,color:Colors.grey,bold: false,lines: 1);
}
textGlobalBlack12Bold16({required BuildContext context,text}){
  return textGlobal(text:text ,context: context,fontSize: 16.0,color:Colors.black45,bold: true);
}

textGlobalGreyBold13({required BuildContext context,text}){
  return textGlobal(text:text ,context: context,fontSize: 13.0,color:Colors.grey,bold: true);
}
textGlobalblueBold13({required BuildContext context,text}){
  return textGlobal(text:text ,context: context,fontSize: 13.0,color:Colors.indigo,bold: true);
}
textGlobalDarkCyanBold13({required BuildContext context,text}){
  return textGlobal(text:text ,context: context,fontSize: 13.0,color:blueDark,bold: true,
      lines: 20);
}
textGlobalDarkCyanBold16({required BuildContext context,text}){
  return textGlobal(text:text ,context: context,fontSize: 16.0,color:blueDark,bold: true,
      lines: 20);
}
textGlobalGreyBold8({required BuildContext context,text}){
  return textGlobal(text:text ,context: context,fontSize: 7.0,color:Colors.grey,bold: true);
}
textGlobalGreyBold13Lines({required BuildContext context,text}){
  return textGlobal(text:text ,context: context,fontSize: 13.0,color:Colors.grey,bold: true,lines: 2);
}
textGlobalBlackBold13Lines({required BuildContext context,text}){
  return textGlobal(text:text ,context: context,fontSize: 13.0,color:Colors.black,bold: true,lines: 4);
}
textGlobalGreyNormal13({required BuildContext context,text}){
  return textGlobal(text:text ,context: context,fontSize: 13.0,color:Colors.grey,bold: false);
}

textGlobalGreyNormal13Lines({required BuildContext context,text}){
  return textGlobal(text:text ,context: context,fontSize: 13.0,color:Colors.grey,bold: false,lines: 35);
}

textGlobalGreyNormalLines13({required BuildContext context,text}){
  return textGlobal(text:text ,context: context,fontSize: 13.0,color:Colors.grey,bold: false,lines: 3);
}
textGlobalBlackBold13({required BuildContext context,text}){
  return textGlobal(text:text ,context: context,fontSize: 13.0,color:Colors.black,bold: true);
}
textGlobalBlackBold10({required BuildContext context,text}){
  return textGlobal(text:text ,context: context,fontSize: 10.0,color:blueDark,bold: true);
}
textGlobalBlackNormal16({required BuildContext context,text}){
  return textGlobal(text:text ,context: context,fontSize: 16.0,color:blueDark,bold: false,lines: 40);
}
textGlobalBlackNormal13({required BuildContext context,text}){
  return textGlobal(text:text ,context: context,fontSize: 13.0,color:blueDark,bold: false,lines: 10);
}
textGlobalWhiteNormal16({required BuildContext context,text}){
  return textGlobal(text:text ,context: context,fontSize: 10.0,color:white2,bold: false);
}
textGlobalWhiteNormal14({required BuildContext context,text}){
  return textGlobal(text:text ,context: context,fontSize: 14.0,color:white2,bold: false);
}

textGlobalBlackBold35({required BuildContext context,text}){
  return textGlobal(text:text ,context: context,fontSize: 35.0,color:white2,bold: true);
}
