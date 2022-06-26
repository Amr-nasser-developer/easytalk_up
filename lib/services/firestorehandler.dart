import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class FireStoreServices{
  Stream  getDataStream({required collectionName,documentId,bool? where,whereKey,whereValue}) {
    CollectionReference getCollection = FirebaseFirestore.instance.collection(collectionName);
    try {
      if (documentId != null) {
        return getCollection.doc(documentId).snapshots();
      }
      else {
        if(where==true) {
          return getCollection.where(whereKey,isEqualTo:whereValue).snapshots();
        }else{
          return getCollection.snapshots();
        }
      }
    } catch (ex) {

      throw ex;
    }
  }
  getData({required collectionName,documentId,bool? where,whereKey,whereValue}) {
    CollectionReference getCollection = FirebaseFirestore.instance.collection(collectionName);
    try {
      if (documentId != null) {
        return getCollection.doc(documentId).get();
      }
      else {
        if(where==true) {
          return getCollection.where(whereKey,isEqualTo:whereValue).get();
        }else{
          return getCollection.get();
        }
      }
    } catch (ex) {
      throw ex;
    }
  }



  updateCollection({required Map<String,dynamic> map, required String doc,required String? docField,required collectionName}){
try {
  CollectionReference getCollection = FirebaseFirestore.instance.collection(
      collectionName);
  if (docField != null) {
    return getCollection
        .doc(doc)
        .set({
      docField: map
    }, SetOptions(merge: true)).then((value) {
      //Do your stuff.
    });
  } else {
    return getCollection.doc(doc).set(map, SetOptions(merge: true)).then((
        value) {
      //Do your stuff.
    });
  }
}catch(ex){
  print(ex);
  throw ex;
}
  }

}