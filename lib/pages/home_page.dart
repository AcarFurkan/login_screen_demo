import 'package:flutter/material.dart';
import 'package:flutter_login_ui_demo/core/enums/auth_state_enum.dart';
import 'package:get/get.dart';

import '../controller/page_controller.dart';
import '../controller/theme_controller.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageStateController controller = Get.put(PageStateController());
  final String welcomeText = "Welcome ";
  final String signOut = "Sign Out";
  ThemeController themeController = Get.put(ThemeController());

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
      onPressed: () => controller.auth
          .signOut()
          .then((value) => controller.setAuthState = AuthState.notLoggedIn),
      child: Text(signOut));

  Text get buildWelcomeText => Text(welcomeText +
      (controller.auth.currentUser != null
          ? controller.auth.currentUser!.email ?? "email null but user exist"
          : "nulll user"));
           GetBuilder<ThemeController> get buildSwitchListTile =>
      GetBuilder<ThemeController>(
          builder: (controller) => SwitchListTile(
              value: controller.isDarkMode,
              onChanged: (c) => controller.toggleDarkMode()));

//Obx get buildSwitchListTile => Obx(
//      () => SwitchListTile(
//          value: themeController.isDarkMode,
//          onChanged: (valeu) {
//            themeController.toggleDarkMode();
//           setState(() {
//             Get.isDarkMode
//                 ? Get.changeTheme(ThemeData.light().copyWith(
//                     textSelectionTheme: const TextSelectionThemeData(
//                         cursorColor: Colors.green),
//                     inputDecorationTheme: const InputDecorationTheme(
//                         focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.green)),
//                         border: OutlineInputBorder())))
//                 : Get.changeTheme(ThemeData.dark().copyWith(
//                     primaryColor: Colors.green,
//                     iconTheme: const IconThemeData(color: Colors.green),
//                     textSelectionTheme: const TextSelectionThemeData(
//                       cursorColor: Colors.green,
//                     ),
//                     inputDecorationTheme: const InputDecorationTheme(
//                         focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.green)),
//                         border: OutlineInputBorder())));
//           });
//          }),
//    );
}
