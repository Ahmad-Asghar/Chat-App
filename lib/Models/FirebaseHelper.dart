import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Usermodel.dart';

class FirebaseHelper{

   static Future<UserModel?> getUserMOdelById( String uid) async{

     print("ok ok");
    UserModel? usermodel;
    DocumentSnapshot docsnap=await FirebaseFirestore.instance.collection("Users").doc(uid).get();

    if(docsnap.data()!=null){
      usermodel=UserModel.fromMap(docsnap.data() as Map<String,dynamic>);
    }
    return usermodel;

  }
}