//import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart' show   BuildContext, Center, Column, EdgeInsets,Key, State, StatefulWidget, TextEditingController, Widget;
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:provider/provider.dart';
import 'package:translationchat/Screens/chat/chatscreen.dart';
import 'package:translationchat/constants/colors.dart';
import 'package:translationchat/models/roommodel.dart';
import 'package:translationchat/provider/chatprovider.dart';
import 'package:translationchat/provider/userprovider.dart';
import 'package:translationchat/shared/components/back.dart';
import 'package:translationchat/shared/components/drawer.dart';
import 'package:translationchat/shared/components/navigator.dart';
import 'package:translationchat/shared/components/progress.dart';
import 'package:translationchat/shared/components/sizedboxglobal.dart';
import 'package:translationchat/shared/text_global.dart';
import 'package:translationchat/shared/widgets/circleavatatimage.dart';
import 'chat_screen_copy.dart';


class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);
  @override
  ContactScreenState createState() => ContactScreenState ();
}

class ContactScreenState extends State<ContactScreen> {
  // const _SignUpState({Key? key}) : super(key: key);const MyHomePage({Key? key, required this.title}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late final TextEditingController controller =TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }
  init() async {

    final validationService = Provider.of<ChatProvider>(
        context, listen: false);
    final validationService2 = Provider.of<UserProvider>(
        context, listen: false);
    //validationService2.getUserProfile();
var c=await validationService.getContact();
   await validationService.getListContacts(c);
//await _getContacts();
  }

 /* _getContacts() async {
    Future<List<Contact>> futureContacts = ContactsService.getContacts(withThumbnails: false)
        .then((value) => value.map((e) => Contact.fromMap(e.toMap())).toList());
    var contacts = await futureContacts.then((value) => value.map((e) => e.toMap()).toList());
    print(contacts);

  }*/
  @override
  Widget build(BuildContext context) {
    final validationService = Provider.of<ChatProvider>(context,listen: false);
    final validationService2 = Provider.of<UserProvider>(context,listen: false);
    return  SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer:
        navigationDrawer()
        ,
        backgroundColor: darkCyan,
        body:
        Center(
            child: Container(
              //padding: const EdgeInsets.only(10),
              height: MediaQuery.of(context).size.height,
              color: cyan,
              child: Padding(
                padding: const EdgeInsets.only(top: 20,left: 0,right: 0),
                child: Column(children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [

                      Back(),
                    Expanded(child:   textGlobalWhiteBold18(context: context,text: "لمعرفه من لديهم حساب من معارفك "),
                  ),
                    ],),
                  ),
                  Expanded(
                    child: Container(color: Colors.white,width: MediaQuery.of(context).size.width,child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Column(children: [

    Consumer<ChatProvider>(
    builder: (context, provider, child) {
    if (provider.listContactsGeneralState.hasData) {
    return Expanded(child: ListView.builder(
    itemCount: validationService.listContactsGeneralState.data!.length,
    itemBuilder: (BuildContext context,int index){
  return   Padding(
    padding:const EdgeInsets.only(left: 15.0,right:15.0,top: 15.0 ),
    child: Column(children: [
    FlatButton(
    onPressed: (){
      String firebaseChatId ;
      print("///////////////////////////////");
      print(validationService2.listUserProfileGeneralState
          .data!.id);
      print("///////////////////////////////");
      if(validationService2.listUserProfileGeneralState.hasData==true) {
        if(int.parse(validationService2.listUserProfileGeneralState
            .data!.id)<provider.listContactsGeneralState.data![index].id){
          firebaseChatId= validationService2.listUserProfileGeneralState
              .data!.id + "_" +
              provider.listContactsGeneralState.data![index].id.toString();
        }else{
          firebaseChatId=provider.listContactsGeneralState.data![index].id.toString()  + "_"
              +validationService2.listUserProfileGeneralState
                  .data!.id;
        }


        AppNavigator.navigateTo(
            context, ChatScreen(roomBool: false,roomModel: RoomModel(
            updatedAt: provider
                .listContactsGeneralState.data![index].updatedAt,
            isActive: provider
                .listContactsGeneralState.data![index].isActive,

            favoriteId: 0,imageUrl: provider
            .listContactsGeneralState.data![index].imageUrl,email: "",user2Id: provider
            .listContactsGeneralState.data![index].id.toString()
            ,
            fireBaseChatId: firebaseChatId,
            name: provider
                .listContactsGeneralState.data![index].name,
            mobileNumber: "",
            lastMessage: '',
            lastMessageTime: '',
            chatId: ''),
          user1: validationService2.listUserProfileGeneralState.data!.idModify,));
      }
    },
    child: Container(
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
    Row(children: [ circleAvatarImage(provider.listContactsGeneralState.data![index].imageUrl,false),
    sizedBoxGlobalWidth10(),
    Column(children: [
    textGlobalLightCyanNormal12(context: context,text: validationService.listContactsGeneralState.data![index].name),
   // textGlobalBlackBold13(context: context,text: "السلام عليكم"),

    ],)
    ]),

//    textGlobalBlackNormal13(context: context,text: "10:15"),
    ],),
    ),
    )
    , const Divider(color: Colors.grey,thickness: 1,)
    ],),
    );
    }
    ),);
    }else{
      return Center(child: progress());
    }
    }
                        ),

                      ],),
                    ),),
                  )



                ],),
              ),
            )),),
    );

  }



}
