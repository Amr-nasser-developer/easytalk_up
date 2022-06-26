import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:translationchat/provider/userprovider.dart';

 counteryPicker(BuildContext context){
   final validationService = Provider.of<UserProvider>(context);
 return showCountryPicker(
    context: context,
    showPhoneCode: true, // optional. Shows phone code before the country name.
    onSelect: (Country country) {
      validationService.countryCode=country.countryCode;

    },
  );
}