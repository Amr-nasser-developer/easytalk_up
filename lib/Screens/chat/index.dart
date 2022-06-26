import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class Login2 extends StatefulWidget {
  const Login2({Key? key}) : super(key: key);
  @override
  HomeList createState() => HomeList ();
}
class HomeList extends State<Login2> {

 // FirebaseFirestore db = FirebaseFirestore.instance;

int x=20;



  @override
  Widget build(BuildContext context) {
   //return Container();


        return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('books').snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
              // count of events
              //final int eventCount = snapshot.data!.docs.length;
              //print(snapshot.data!.docs[0].data());
              if (snapshot.hasError) {
                return  Text('Error: ${snapshot.error}');
              }
              switch (snapshot.connectionState){
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());
                default:
return
                  Scaffold(
                    body: NotificationListener<ScrollEndNotification>(
                      onNotification: (scrollEnd) {
                        var metrics = scrollEnd.metrics;
                        if (metrics.atEdge) {
                          if (metrics.pixels == 0) {
                            print('At top');
                            setState(() {
                              x = 20 + x;
                            });
                          }
                        }
                        return true;
                      },
                      child: ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (_, i) => ListTile(title: Text('Item $i')),
                        itemCount: x,
                      ),
                    ),
                  );

                  /*return ListView.builder(
                      itemCount: 3 ,
                      itemBuilder: (context, index) {
                     //   final Object? document = snapshot.data!.docs[index].data();
                        return  Container(child:  Text(snapshot.data!.docs[index].id));
                      }
                  );*/
              }
            });




  }
}