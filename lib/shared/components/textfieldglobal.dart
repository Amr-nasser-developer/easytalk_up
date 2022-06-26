import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:translationchat/constants/colors.dart';



class TextFieldGlobal extends StatelessWidget{
  TextFieldGlobal({Key? key,required this.focus ,required this.keyboardType ,required this.controller,required this.hint,required this.label,required this .widthBorder,required this.myFocusNode}) : super(key: key);
  final TextEditingController controller ;
  final String hint;
  final keyboardType;
  final double widthBorder;
  final Color label;
  late FocusNode myFocusNode=FocusNode();

  bool focus=true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Directionality(
      textDirection: TextDirection.rtl,
      child:
      TextField(

//textInputAction: TextInputAction.next,

        style:GoogleFonts.cairo(fontSize: 16,color:Colors.black,fontWeight: FontWeight.bold),

        //autocorrect: true,
        focusNode: myFocusNode,
        cursorColor: darkCyan,
        keyboardType:keyboardType,
        controller: controller,
        decoration:  InputDecoration(
          hintStyle: GoogleFonts.cairo(fontSize: 16,color:Colors.grey,fontWeight: FontWeight.bold),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color:label, width: widthBorder),
          ),
          enabledBorder:UnderlineInputBorder(
            borderSide: BorderSide(color:label, width: widthBorder),
          ) ,

          border:  UnderlineInputBorder(
            borderSide: BorderSide(color: label, width: 0.0),
          ),
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hoverColor: darkCyan,
          fillColor: darkCyan,
          focusColor: darkCyan,

          hintText: hint,
        ),


      ),
    );
  }
}
class TextFieldGlobal2 extends StatelessWidget{
  TextFieldGlobal2({Key? key,  required this.keyboardType ,required this.controller,required this.hint,required this.label,required this .widthBorder,required this.myFocusNode}) : super(key: key);
  final TextEditingController controller ;
  final String hint;
  final keyboardType;
  final double widthBorder;
  final Color label;
  late FocusNode myFocusNode=FocusNode();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Directionality(
      textDirection: TextDirection.rtl,
      child:
      TextField(
        autofocus: true,
//textInputAction: TextInputAction.next,

        style:GoogleFonts.cairo(fontSize: 16,color:Colors.white,fontWeight: FontWeight.bold),
        keyboardType: TextInputType.multiline,
        // autocorrect: true,
        focusNode: myFocusNode,
        cursorColor: darkCyan,
        minLines: 1,//Normal textInputField will be displayed
        maxLines: 3,
        controller: controller,
        decoration:  InputDecoration(
          hintStyle: GoogleFonts.cairo(fontSize: 16,color:Colors.black12,fontWeight: FontWeight.bold),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color:label, width: widthBorder),
          ),
          enabledBorder:UnderlineInputBorder(
            borderSide: BorderSide(color:label, width: widthBorder),
          ) ,

          border:  UnderlineInputBorder(
            borderSide: BorderSide(color: label, width: 0.0),
          ),
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hoverColor: darkCyan,
          fillColor: darkCyan,
          focusColor: darkCyan,

          hintText: hint,
        ),


      ),
    );
  }
}