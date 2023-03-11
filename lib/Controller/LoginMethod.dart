
import 'package:chat_app/Views/HomePage.dart';
import 'package:chat_app/Widgets/Snackbar.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/Models/Usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app/Widgets/Snackbar.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/Models/Usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import '../Views/CompleteProfilePage.dart';
class LoginMethod extends GetxController {

  Snackbar snack = Get.put(Snackbar());

  LoginMethod1( String emailcontroller,String passwordcontroller) async {

    UserCredential? credentials;
    try{

      credentials = await FirebaseAuth.instance.
      signInWithEmailAndPassword(email: emailcontroller, password: passwordcontroller);
      String uid=credentials.user!.uid;
      DocumentSnapshot userData = await FirebaseFirestore.instance.collection("Users").doc(uid).get();
      UserModel userModel=UserModel.fromMap(userData.data() as Map<String ,dynamic>);

      snack.snackBar("Congratulations", 'Successfully Loged In',Colors.blue,Colors.white,"images/checked.png");
      Get.to(HomePage(userModel: userModel, firebaseuser: credentials.user!));

    }
    on FirebaseAuthException catch(exception){
      snack.snackBar("Error", exception.code.toString(),Colors.red.shade400,Colors.white,"images/close.png");
    }


  }



}



