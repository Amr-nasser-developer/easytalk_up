
import 'package:firebase_auth/firebase_auth.dart';
import 'package:translationchat/utils/sharedprefence.dart';
class FirebaseHandler{
  FirebaseAuth auth = FirebaseAuth.instance;

  Future phoneAuth( number) async {
   try{

    String ? verificationIdd;
    print(".................");
    print(number);

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: number,
      verificationCompleted: (PhoneAuthCredential credential) {

      },
      verificationFailed: (FirebaseAuthException e) {
        print(e);
      },

      codeAutoRetrievalTimeout: (String verificationId) {},
      codeSent: (String verificationId, int? forceResendingToken) async {
        print(verificationId);
        await SharedPreferenceHandler.setVerificationId(verificationId);
      });
        }catch(ex){
     rethrow;
    }



  }
  Future <bool> checkCode(smsCode) async {
    //bool value=false;
    try{
    String  verificationId =await SharedPreferenceHandler.getVerificationId();
    print(verificationId);
      PhoneAuthCredential phoneAuthCredential =
      PhoneAuthProvider.credential(smsCode: smsCode, verificationId: verificationId,);
      final FirebaseAuth auth = FirebaseAuth.instance;
     var value=await auth.signInWithCredential(phoneAuthCredential);
     if(value!=null){
       return true;
     }else{
       return false;
     }

     /* await auth.signInWithCredential(phoneAuthCredential).then((valuee) {
print(valuee);
        if(valuee.user!.uid!=null){
          value=true;
        }else{
          value=false;
        }
      });*/

      //await auth.signInWithCredential(phoneAuthCredential);
    }catch(ex){

      rethrow;
    }



  }


}
