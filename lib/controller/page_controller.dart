import 'package:flutter/material.dart';
import 'package:flutter_login_ui_demo/core/enums/page_state_enum.dart';
import 'package:flutter_login_ui_demo/pages/home_page.dart';
import 'package:flutter_login_ui_demo/pages/welcome_page.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PageStateController extends GetxController {
  final Rx<PageState> _pageState = PageState.welcome.obs;
  final Rx<bool> _isObscureText = true.obs;

  final Rxn<User> _user = Rxn<User>();

  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  PageState get getPageState => _pageState.value;
  User? get getUser => _user.value;

  set setUser(User? state) {
    _user.value = state;
  }

  bool get isObscureText => _isObscureText.value;

  get changeObscureText => _isObscureText.value = !_isObscureText.value;

  PageStateController() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();

    auth.authStateChanges().listen((User? user) {
      if (user != null) {
        if (Get.currentRoute != "/HomePage") {
          Get.offAll(() => HomePage());
        }
      } else {
        if (Get.currentRoute != "/WelcomePage") {
          Get.offAll(() => WelcomePage());
        }
      }
    });
  }
  final FirebaseAuth auth = FirebaseAuth.instance;

  void setLoginPage() => _pageState.value = PageState.login;
  void setRegisterPage() => _pageState.value = PageState.register;
  void setWelcomePage() => _pageState.value = PageState.welcome;

  Future<void> tappedBottomButton() async {
    try {
      if (getPageState == PageState.register) {
        await auth.createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim());
      } else if (getPageState == PageState.login) {
        await auth.signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim());
      } else {
        setLoginPage();
      }
    } on FirebaseAuthException catch (e) {
       
       Get.snackbar("OOOPPPSSS", e.message.toString(),colorText: Color.fromARGB(255, 65, 227, 75));
      print(e.message);
    }
  }

  void tappedisHaveAccountButton() {
    if (getPageState == PageState.login) {
      setRegisterPage();
    } else {
      setLoginPage();
    }
  }
}
