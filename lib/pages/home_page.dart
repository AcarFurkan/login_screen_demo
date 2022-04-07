import 'package:flutter/material.dart';
 import 'package:get/get.dart';

import '../controller/page_controller.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageStateController controller = Get.put(PageStateController());
  final String welcomeText = "welcome";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [buildSignOutButton, buildWelcomeText, buildSwitchListTile],
        ),
      ),
    );
  }

  ElevatedButton get buildSignOutButton => ElevatedButton(
      onPressed: () => controller.auth.signOut(), child: Text("Sign Out"));

  Text get buildWelcomeText => Text(welcomeText +
      (controller.auth.currentUser != null
          ? controller.auth.currentUser!.email ?? "email null but user exist"
          : "nulll user"));

  SwitchListTile get buildSwitchListTile => SwitchListTile(
      value: Get.isDarkMode,
      onChanged: (valeu) {
        setState(() {
          Get.isDarkMode
              ? Get.changeTheme(ThemeData.light().copyWith(
                  textSelectionTheme:
                      const TextSelectionThemeData(cursorColor: Colors.green),
                  inputDecorationTheme: const InputDecorationTheme(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                      border: OutlineInputBorder())))
              : Get.changeTheme(ThemeData.dark().copyWith(
                  primaryColor: Colors.green,
                  iconTheme: IconThemeData(color: Colors.green),
                  textSelectionTheme: const TextSelectionThemeData(
                    cursorColor: Colors.green,
                  ),
                  inputDecorationTheme: const InputDecorationTheme(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                      border: OutlineInputBorder())));
        });
      });
}
