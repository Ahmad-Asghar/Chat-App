import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Textfield extends StatelessWidget {
  final String mesege;
  final TextEditingController email;
  final IconData icon;
  final String hintext;
  const Textfield({Key? key,
    required this.email,
    required this.icon,
    required this.hintext,
  required this.mesege
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w,vertical: 2.5.h),
      child: TextFormField(
        validator: (value){
          if(value!.isEmpty){
            return mesege;
          }
          else{
            return null;
          }
        },
        controller: email,
        decoration: InputDecoration(
          hintText: hintext,
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }
}
