import 'dart:io';

import 'package:chat_app/Models/Usermodel.dart';
import 'package:chat_app/Views/HomePage.dart';
import 'package:chat_app/Widgets/TextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../Controller/CompleteProfile.dart';
import '../Widgets/Snackbar.dart';

class CompleteProfile extends StatefulWidget {
  final UserModel userModel;
  final User firebaseuser;
  const CompleteProfile({Key? key, required this.userModel, required this.firebaseuser}) : super(key: key);

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {

File? imageFile;
Snackbar snack=Get.put(Snackbar());
CompleteProfileData  cmp=Get.put(CompleteProfileData ());
  selectImageSource(){
    showModalBottomSheet(
     shape: RoundedRectangleBorder(
       borderRadius: BorderRadius.only(
         topRight: Radius.circular(15),
         topLeft: Radius.circular(15)
       )
     ),
        context: context,
        builder: (context) {
          return Padding(
            padding:  EdgeInsets.all(4.h),
            child: Wrap(
              children: [
                Padding(
                  padding:  EdgeInsets.only(bottom: 2.h),
                  child: ListTile(
                    selectedTileColor: Colors.yellow[800],
                    selected: true,
                    splashColor: Colors.blue,
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(20)
                   ),
                    onTap: (){

                        getImagefromGallery();

                      Navigator.pop(context);
                    },
                    leading: Icon(Icons.image,
                    color: Colors.black,),
                    title: Text('Gallery',style: TextStyle(
                      color: Colors.black,
                    ),),
                  ),
                ),
                ListTile(
                  selectedTileColor: Colors.yellow[800],
                  selected: true,
                  splashColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  onTap: (){

                      getImagefromCamera();
                    Navigator.pop(context);
                  },
                  leading: Icon(Icons.camera_alt,color: Colors.black,),
                  title: Text('Camera',style: TextStyle(
                    color: Colors.black,
                  ),),
                ),

              ],
            ),
          );
        }
    );
  }
  getImagefromCamera (){
    Future<void> _getFromGallery() async {

      final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        setState(() {
          imageFile = File(pickedFile.path ) as File?;
        });

      }
    }

    _getFromGallery();
  }
  getImagefromGallery (){
    Future<void> _getFromGallery() async {

      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          imageFile = File(pickedFile.path ) as File?;
        });

      }
    }

    _getFromGallery();
  }
  final _formkey=GlobalKey<FormState>();
  TextEditingController completeprofilecontroller=TextEditingController();
  TextEditingController aboutcontroller=TextEditingController();
  @override


  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor:  Colors.blue,
            automaticallyImplyLeading: false,
      centerTitle: true,
            title: Text("Complete Profile",style: TextStyle(

            ),),

    ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            
            children: [

              CupertinoButton( onPressed: (){

selectImageSource();

              },
                  child: CircleAvatar(
radius: 10.h,
                  child: imageFile!=null?CircleAvatar(

                    backgroundImage: FileImage(
                      imageFile!,
                    ),
                    radius: 10.h,
                  ):CircleAvatar(
                    backgroundColor: Colors.yellow[800],
                    child: Icon(Icons.person_outline_outlined,
                      color: Colors.white,
                      size: 9.h,),
                    radius: 10.h,

                  )
                  )
      ),
Form(
    key: _formkey,
    child: Column(
  children: [

    Textfield(email: completeprofilecontroller, icon: Icons.person, hintext: "Full Name", mesege: "Enter Name"),
    Textfield(email: aboutcontroller, icon: Icons.person, hintext: "About", mesege: "Could not be empty"),
  ],
)),


              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                onPressed: (){
                  if(_formkey.currentState!.validate()){

                    print("Validation Working");
                    if(completeprofilecontroller==""||imageFile==null){
                      snack.snackBar("Error", "Please Fill Name or Profile Picture",Colors.red.shade400,Colors.white,"images/close.png");
                    }else{
                      cmp.uploadProfilePic(imageFile!,completeprofilecontroller.text.toString(),widget.firebaseuser,widget.userModel);
                    }
                   // Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                  }
                 
                },
                color: Colors.blue,
                height: 7.h,
                minWidth: 30.w,
                child: Text("Submit",
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
    ));
  }
}
