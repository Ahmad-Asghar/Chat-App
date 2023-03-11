

import 'package:chat_app/Models/Usermodel.dart';
import 'package:chat_app/Views/HomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../Widgets/Snackbar.dart';

class CompleteProfileData extends GetxController{

  Snackbar snack=Get.put(Snackbar());
  Future<void> uploadProfilePic(File imageFile,String fullName, User user ,UserModel model ) async {
    
    UploadTask uploadTask=FirebaseStorage.instance.ref("Profile Pictures").child(user.uid.toString()).putFile(imageFile);
    TaskSnapshot snapshot= await uploadTask;

String imgUrl= await snapshot.ref.getDownloadURL();


model.profilepic=imgUrl;
model.fullName=fullName.toString();
await FirebaseFirestore.instance.collection("Users").doc(user.uid.toString()).set(model.toMap())
    .onError((error, stackTrace) => {

  snack.snackBar("Error", error.toString(),Colors.red.shade400,Colors.white,"images/close.png")
});

    snack.snackBar("Confirmation", "Successfully Completed Profile",Colors.blue,Colors.white,"images/checked.png");
    Get.to(HomePage(userModel: model, firebaseuser: user));
  }

}

//     .then((value) =>
// {
// snack.snackBar("Confirmation", "Successfully Signed In",Colors.blue,Colors.white,"images/checked.png")
// }).onError((error, stackTrace) => {
//
// snack.snackBar("Error", error.toString(),Colors.red.shade400,Colors.white,"images/close.png")
// });