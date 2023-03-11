import 'package:chat_app/Controller/SignUpMethod.dart';
import 'package:chat_app/Views/CompleteProfilePage.dart';
import 'package:chat_app/Views/LoginPage.dart';
import 'package:chat_app/Widgets/TextField.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';
class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
 SignUpMethod signupobject=Get.put(SignUpMethod());
  final _formkey=GlobalKey<FormState>();
  TextEditingController emailcontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();
  TextEditingController confirmpasswordcontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
            color: Colors.white     ,
            elevation: 0,
            child:  Row(

              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?",
                  style: TextStyle(
                      fontSize: 2.3.h,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow[800]
                  ),
                ),
                TextButton(onPressed: (){
                  Get.to(()=>const LoginPage());
                }, child: Text("Login"))
              ],
            )
        ),

        body: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(text: "Let's " ,style: TextStyle(fontSize:4.h,fontWeight: FontWeight.bold,color: Colors.blue[900])),
                        TextSpan(text: " Sign Up" ,style: TextStyle(fontSize:4.h,fontWeight: FontWeight.bold,color: Colors.yellow[800])),
                      ],
                    ),
                  ),
                  SizedBox(width: 6.w,),
                  Image(image: AssetImage("images/chat.png"),
                    height: 8.h,
                  ),
                ],
              ),
              Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Textfield(email: emailcontroller, icon: Icons.alternate_email, hintext: "Email", mesege: 'Enter Email',),
                      Textfield(email: passwordcontroller, icon: Icons.key, hintext: "Password", mesege: 'Enter Password',),
                      Textfield(email: confirmpasswordcontroller, icon: Icons.key, hintext: "Confirm Password", mesege: 'Enter Password',)
                    ],
                  )),
              SizedBox(height: 3.h,),
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                onPressed: (){
                  if(_formkey.currentState!.validate()){
                    print("Validation Working");
                   signupobject.SignUp(emailcontroller.text.toString(),passwordcontroller.text.toString());


                  }

                },
                color: Colors.blue,
                height: 7.h,
                minWidth: 30.w,
                child: Text("Sign Up",
                  style: TextStyle(
                      fontSize: 2.3.h,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),),


            ],
          ),
        ),
      ),
    );
  }
}
