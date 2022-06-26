import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';


Widget  codeNumber({required TextEditingController controller,required BuildContext context}){

 return Padding(
    padding: const EdgeInsets.all(15),
    child: Center(
      child: SizedBox(
        height: 100.0,
        child: GestureDetector(

          child: PinCodeTextField(
            pinBoxRadius: 8,
            //pinBoxRadius:BorderRadius.circular(12),
            autofocus: true,
            controller: controller,
            // hideCharacter: true,
            highlight: true,
            highlightColor: Colors.black12,
            defaultBorderColor: Colors.black12,
            hasTextBorderColor: Colors.cyanAccent,
            maxLength: 6,
            hasError: false,


            onDone: (text) {

            },
            pinBoxWidth: 40,
            maskCharacter: "0",
            pinBoxHeight: 64,
            //hasUnderline: true,
            wrapAlignment: WrapAlignment.spaceAround,
            pinBoxDecoration:
            ProvidedPinBoxDecoration.defaultPinBoxDecoration,
            pinTextStyle: const TextStyle(fontSize: 22.0),
            pinTextAnimatedSwitcherTransition:
            ProvidedPinBoxTextAnimation.scalingTransition,
//                    pinBoxColor: Colors.green[100],
            pinTextAnimatedSwitcherDuration:
            const Duration(milliseconds: 300),
            highlightAnimation: true,
            highlightAnimationBeginColor: Colors.black12,
            highlightAnimationEndColor: Colors.white12,
            keyboardType: TextInputType.number,
          ),
        ),
      ),
    ),
  );

}