import 'package:flutter/material.dart';

import '../../shared/components/back.dart';

class ItemGalleryView extends StatelessWidget {
  final String img;

  const ItemGalleryView({Key? key, required this.img}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Container(
          color: Colors.black,
          child: Center(
            child: SingleChildScrollView(
              child: Column(children:[
          Row(children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: InkWell(onTap: (){
                Navigator.of(context).pop();
              },child: const Icon(Icons.arrow_back_ios,color: Colors.white)),
            ),
          ],),


                SizedBox(height: MediaQuery.of(context).size.height-200,width: MediaQuery.of(context).size.width,child: Image.network(img))]),
            ),
          ),
        ));
  }
}
