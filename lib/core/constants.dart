import 'package:flutter/material.dart';
import 'package:get/get.dart';

const kRedColor = Colors.red;
const kGreenColor = Colors.green;
const kBlackColor = Colors.black;

const textStyleForViewTransaction = TextStyle(fontSize: 18, color: kBlackColor);

getSnackbarFunction(String title, Color color) {
  Get.snackbar('', "",
      titleText: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
      backgroundColor: color,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      padding: const EdgeInsets.all(0));
}
