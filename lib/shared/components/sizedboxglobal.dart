import 'package:flutter/cupertino.dart';


Widget sizedBoxGlobal({index,height,width}){
  switch (index){
    case 0:
      return SizedBox(height: height,);

    case 1:
      return SizedBox(width: width,);

    default:
      return SizedBox(width: width,height: height,);




  }

}
Widget sizedBoxGlobalHeight20(){
  return sizedBoxGlobal(index: 0,height: 20.0);
}
Widget sizedBoxGlobalHeight80(){
  return sizedBoxGlobal(index: 0,height: 80.0);
}
Widget sizedBoxGlobalHeight40(){
  return sizedBoxGlobal(index: 0,height: 40.0);
}

Widget sizedBoxGlobalHeight10(){
  return sizedBoxGlobal(index: 0,height: 10.0);
}
Widget sizedBoxGlobalHeight30(){
  return sizedBoxGlobal(index: 0,height: 30.0);
}
Widget sizedBoxGlobalWidth10(){
  return sizedBoxGlobal(index: 1,width: 10.0);
}Widget sizedBoxGlobalWidth20(){
  return sizedBoxGlobal(index: 1,width: 20.0);
}
Widget sizedBoxHeight80(){
  return sizedBoxGlobal(index: 1,height:80.0);
}
