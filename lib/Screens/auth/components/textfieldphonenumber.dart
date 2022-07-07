import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translationchat/constants/colors.dart';
import 'package:translationchat/provider/userprovider.dart';
import 'package:translationchat/shared/components/countrypicker.dart';
import 'package:translationchat/shared/components/sizedboxglobal.dart';
import 'package:translationchat/shared/components/textfieldglobal.dart';
import 'package:translationchat/shared/text_global.dart';

Widget textFieldPhoneNumber(TextEditingController controller,BuildContext context){
  final validationService = Provider.of<UserProvider>(context);
  final focusNode = FocusNode();
  return   Container(decoration: const BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(20)),

  ),child: Padding(
    padding:const EdgeInsets.all(10)         ,
    child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [

      //   SizedBox(width: 20,),

      Flexible(child:  TextFieldGlobal(myFocusNode: focusNode,focus: false,keyboardType: TextInputType.number,label: Colors.black12,
        controller:controller ,hint: "5xxxxxxx",widthBorder:2.0)),
      Icon(Icons.keyboard_arrow_down_sharp,color: black,),
      sizedBoxGlobalWidth10(),
      GestureDetector(
          onTap: (){
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
  ));
}