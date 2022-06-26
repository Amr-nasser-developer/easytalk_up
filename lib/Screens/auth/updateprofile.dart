import 'package:flutter/cupertino.dart' show   BuildContext, Center, Column, Container, EdgeInsets,Image, Key, MainAxisAlignment,  Row, SingleChildScrollView, State, StatefulWidget, TextEditingController, Widget;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translationchat/constants/colors.dart';
import 'package:translationchat/constants/images.dart';
import 'package:translationchat/provider/userprovider.dart';
import 'package:translationchat/shared/components/back.dart';
import 'package:translationchat/shared/components/bottomsheetglobal.dart';
import 'package:translationchat/shared/components/buttonglobal.dart';
import 'package:translationchat/shared/components/displaysnackbar.dart';
import 'package:translationchat/shared/components/progress.dart';
import 'package:translationchat/shared/components/sizedboxglobal.dart';
import 'package:translationchat/shared/components/textfieldglobal.dart';
import 'package:translationchat/shared/text_global.dart';
import 'package:translationchat/shared/widgets/circleavatatimage.dart';



class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);
  @override
  UpdateProfileState createState() => UpdateProfileState ();
}

class UpdateProfileState extends State<UpdateProfile> {
  // const _SignUpState({Key? key}) : super(key: key);const MyHomePage({Key? key, required this.title}) : super(key: key);
  final focusNode = FocusNode();
  late final TextEditingController nameController =TextEditingController();
updateProfileFunction(key) async {
  final validationService = Provider.of<UserProvider>(context,listen: false);
var response = await  validationService.updateProfile(key,  nameController.text);

print(response);
if(response==200||response==201){
  Navigator.of(context).pop();
 await validationService.getUserProfile();
}
}

  @override
  Widget build(BuildContext context) {
    final validationService = Provider.of<UserProvider>(context,listen: false);
    return  SafeArea(
      child: Scaffold(
          body:SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child:   SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Center(
                    child: Consumer<UserProvider>(
    builder: (context, provider, child) {
    if (provider.listUserProfileGeneralState.hasData) {
                     return Column(children: [

                       Padding(
                         padding: EdgeInsets.all(20),
                         child: Row(mainAxisAlignment: MainAxisAlignment.start,children: [
                           Back()
                         ],),
                       ),
                        sizedBoxGlobalHeight20(),

                        GestureDetector(onTap: (){
                          bottomSheetGlobadl(context: context, body: addCamera(context: context, mainImage: true,sortUploadImage: true), height:200.0);
                        },child: circleAvatarImage(provider.listUserProfileGeneralState.data!.imagePath,true)),
                       const SizedBox(height: 20,),
                       field("الاسم", provider.listUserProfileGeneralState.data!.name, true),
                      const SizedBox(height: 10,),
                       field("الايميل", provider.listUserProfileGeneralState.data!.email, false),

                       const SizedBox(height: 10,),
                       field("رقم التليقون", provider.listUserProfileGeneralState.data!.mobileNumber, false),
                       
                          ],);
    }else{
      return progress();

        }}
                    ),


                      ),














                      //GlobalTextField(controller: controller, hint: hint)


              ))),
    );

  }

  sheetUpdate(name,key){

    return Column(children: [

      textGlobalBlackBold16(context: context,text: key),
      Padding(padding: EdgeInsets.all(10),child: TextFieldGlobal(myFocusNode: focusNode,focus: false,keyboardType: TextInputType.text,controller:nameController ,hint:name,label: darkCyan,widthBorder: 2.0,)),
                                                //  Expanded(child: Container()),
                            sizedBoxGlobalHeight40(),
                            GestureDetector(onTap: () async {
                  updateProfileFunction("name");
                            },child: buttonGlobal(context: context,text: "ارسل"))
    ],);
    
    
  }
  
field(key,value,bool update){
 return Container(
    child:Padding(
      padding: const EdgeInsets.all(10),
      child: 
      Column(children: [
     Row(children: [textGlobalGreyBold16(context: context,text: key),],mainAxisAlignment: MainAxisAlignment.end,) ,
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [

          update==true? FlatButton(onPressed: (){
            bottomSheetGlobadl(context: context,body: sheetUpdate(value,key),height: MediaQuery.of(context).size.height*.65);
          },child: const Icon(Icons.arrow_back_ios)):const SizedBox(height: 0,),


          textGlobalBlackNormal16(context: context,text:value ),

        ],),

      ],)
      


      
    ),
    decoration: BoxDecoration(

      color: Colors.white54,
      borderRadius: BorderRadius.circular(10),
    ),
  );

}

}



