import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_ui_demo/pages/welcome_page.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
            primaryColor: Colors.green,
            indicatorColor: Colors.green,
            iconTheme: const IconThemeData(color: Colors.green),
            textSelectionTheme: const TextSelectionThemeData(
              cursorColor: Colors.green,
            ),
            inputDecorationTheme: const InputDecorationTheme(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green)),
                border: OutlineInputBorder())),
        home: WelcomePage());
  }
}
