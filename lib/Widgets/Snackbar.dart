import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
class Snackbar extends GetxController{

  Future<SnackbarController> snackBar(String title,String message, Color culur,Color textcolor,String image) async {

    return Get.snackbar(
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      snackPosition:SnackPosition.BOTTOM,
      title,
      message,
margin: EdgeInsets.symmetric(horizontal: 5.w,vertical: 5.h),
      colorText: textcolor,
        backgroundColor: culur,
        icon: ImageIcon(
          AssetImage(image),
          color: textcolor,
        ),

    );
  }

}
