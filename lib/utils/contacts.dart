import 'package:flutter_contacts/contact.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class GetContacts{

 static bool  permissionDenied = false;
static List<String>? contactsPhone=[];
static  fetchContacts() async {
    List<Contact>? contacts;
    if (!await FlutterContacts.requestPermission(readonly: true)) {
      permissionDenied=false;
    } else {
     final  contactss = await FlutterContacts.getContacts();
      permissionDenied=true;
      print(contacts);
       List<String>? contactsPhone=[];
      for(int i=0;i<contactss.length;i++){
        final fullContact =
        await FlutterContacts.getContact(contactss[i].id);
   if(fullContact!.phones.isNotEmpty) {
     for (int j = 0; j < fullContact.phones.length; j++) {
       contactsPhone.add(fullContact.phones[j].number.trim());
     }
   }
        }
print(contactsPhone);
        return contactsPhone;

      }
    }
  }



