import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translationchat/provider/userprovider.dart';
import 'package:translationchat/shared/components/back.dart';
import 'package:translationchat/shared/components/progress.dart';
import 'package:translationchat/shared/text_global.dart';

class Information extends StatefulWidget {
  String k;
  String title;
   Information({required this.k,required this.title});
  @override
  InformationState createState() => InformationState ();
}



class InformationState extends State<Information> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }
  init() async {
    final validationService = Provider.of<UserProvider>(context,listen: false);
   await  validationService.getInformation(widget.k);
  }
  @override
  Widget build(BuildContext context) {



    return  SafeArea(
      child: Scaffold(
          body:SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child:
              Consumer<UserProvider>(
                  builder: (context, provider, child) {
                    if (provider.listUserProfileInformationState.hasData) {
                    return  Center(
                          child: Column(children: [
                           
                            Padding(
                              padding: EdgeInsets.all(20),
                              child: Row(mainAxisAlignment: MainAxisAlignment.start,children: [
                              SizedBox(width: 20,),
                                Back(),
                                SizedBox(width: 20,),
                              ],),
                            ),
                            const SizedBox(height: 20,),
                            textGlobalBlackBold16(context: context,text:widget.title),
                            const SizedBox(height: 20,),
                            Row(children: [
                              const SizedBox(width: 10,),
                              Expanded(child:        textGlobalBlackNormal16(context: context,text: provider.listUserProfileInformationState.data)

                    ),
                              const SizedBox(width: 10,),
                            ])

                    ],));
                    }else{
                      //return progress();
                      return  Center(child: progress());
                    }}
              )
             )),
    );

  }



}