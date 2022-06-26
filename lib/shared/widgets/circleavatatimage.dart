import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hexcolor/hexcolor.dart';
Widget circleAvatarImage(imageUrl,bool? big){
  if(imageUrl==null||imageUrl=="") {
    return  CircleAvatar(
      backgroundColor: Colors.white,
      radius:big==false? 25.0:50.0,
      child: CircleAvatar(
        backgroundImage: const AssetImage('assests/user.png'),
        radius:big==false? 23.0:45.0,
      ),
    );
  }else{
    return   CircleAvatar(
      backgroundColor:HexColor("e6e6e6"),
      radius:big==false? 25.0:50.0,
      child: CircleAvatar(

          backgroundImage: NetworkImage(imageUrl),
        radius: big==false? 23.0:45.0,
      ),
    );
  }
}