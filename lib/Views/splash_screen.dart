import 'dart:async';
import 'package:chat_app/Models/FirebaseHelper.dart';
import 'package:chat_app/Views/CompleteProfilePage.dart';
import 'package:chat_app/Views/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:chat_app/Views/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../Models/Usermodel.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

checkUsers() async {
  User? currentuser=FirebaseAuth.instance.currentUser;

  if(currentuser!=null){
    UserModel? fetchedUserModel= await   FirebaseHelper.getUserMOdelById(currentuser.uid) ;
    if(fetchedUserModel!=null){
      Timer(Duration(seconds: 4),(){
        Get.to(HomePage(userModel: fetchedUserModel, firebaseuser: currentuser));
      });
    }
  }
  else{
    Timer(Duration(seconds: 4),(){
      Get.to(LoginPage());
    });
  }

}

   initState() {
    // User? currentuser=FirebaseAuth.instance.currentUser;
    // currentuser?.delete();
   checkUsers();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetImage("images/chat.png"),
                height: 20.h,
              ),
              SizedBox(height: 3.h,),
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: "Let's " ,style: TextStyle(fontSize:5.h,fontWeight: FontWeight.bold,color: Colors.blue[900])),
                    TextSpan(text: " Chat" ,style: TextStyle(fontSize:5.h,fontWeight: FontWeight.bold,color: Colors.yellow[800])),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
