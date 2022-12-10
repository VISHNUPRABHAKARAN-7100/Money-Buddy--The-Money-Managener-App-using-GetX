import 'package:flutter/material.dart';
import 'package:get/get.dart';

const kColorRed = Colors.red;
const kColorGreen = Colors.green;
const kBlackColor = Colors.black;

getSnackbarFunction(String title, Color color) {
  Get.snackbar('', "",
      titleText: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
      backgroundColor: color,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      padding: EdgeInsets.all(0));
}
