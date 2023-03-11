


import 'package:chat_app/Views/HomePage.dart';
import 'package:chat_app/Widgets/Snackbar.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/Models/Usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import '../Views/CompleteProfilePage.dart';

class SignUpMethod extends GetxController{

  Snackbar snack=Get.put(Snackbar());

  SignUp( String emailcontroller,String passwordcontroller) async {

UserCredential? credential;
    try{

     credential = await FirebaseAuth.instance.
      createUserWithEmailAndPassword(email: emailcontroller, password: passwordcontroller);

     String uid=credential.user!.uid;
     UserModel newmodel=UserModel(

       uid: uid,
       email: emailcontroller,
       fullName: "",
       profilepic: "",
     );
     FirebaseFirestore.instance.collection("Users").doc(uid).set(newmodel.toMap());
     snack.snackBar("Confirmation", "Successfully Signed In",Colors.blue,Colors.white,"images/checked.png");
     Get.to(CompleteProfile(userModel: newmodel, firebaseuser: credential!.user!));

    }on FirebaseAuthException catch(exception){
     snack.snackBar("Error", exception.code.toString(),Colors.red.shade400,Colors.white,"images/close.png");
    }

    }
  }



//     .then((value) async {
// print ("ok sronjn");
// String uid=value.user!.uid.toString();
// print(uid);
// // String? uid=usercredentials?.user!.uid.toString();
//
//
//     .then((value){
// print(" New User Added".toString());
//
//
// })
// .onError((error, stackTrace) {
// print(error.toString()+" Here");
// });
//
// snack.snackBar("Confirmation", "Successfully Signed In",Colors.blue,Colors.white,"images/checked.png");
// // Get.to(HomePage());
//
// })
// .onError((error, stackTrace) {
// snack.snackBar("Error", error.toString(),Colors.red.shade400,Colors.white,"images/close.png");
// });
//
