import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  ThemeController() {
    isDarkMode = Get.isDarkMode;
  }
  bool isDarkMode = true;

  void toggleDarkMode() {
    isDarkMode = !isDarkMode;
    if (isDarkMode) {
      Get.changeTheme(ThemeData.dark().copyWith(
          primaryColor: Colors.green,
          iconTheme: IconThemeData(color: Colors.green),
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Colors.green,
          ),
          inputDecorationTheme: const InputDecorationTheme(
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green)),
              border: OutlineInputBorder())));
    } else {
      Get.changeTheme(ThemeData.light().copyWith(
          textSelectionTheme:
              const TextSelectionThemeData(cursorColor: Colors.green),
          inputDecorationTheme: const InputDecorationTheme(
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green)),
              border: OutlineInputBorder())));
    }
    update();
  }
}
