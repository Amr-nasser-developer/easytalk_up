import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Back extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
  return  InkWell(onTap: (){
      Navigator.of(context).pop();
    },child: const Icon(Icons.arrow_back_ios,color: Colors.black));

  }



}