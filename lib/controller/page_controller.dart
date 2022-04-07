import 'package:flutter/material.dart';
import 'package:flutter_login_ui_demo/core/enums/auth_state_enum.dart';
import 'package:flutter_login_ui_demo/core/enums/page_state_enum.dart';
import 'package:flutter_login_ui_demo/pages/home_page.dart';
import 'package:flutter_login_ui_demo/pages/welcome_page.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PageStateController extends GetxController {
  final Rx<PageState> _pageState = PageState.welcome.obs;
  final Rx<bool> _isObscureText = true.obs;
  final Rx<AuthState> _authState = AuthState.notLoggedIn.obs;

  final Rxn<User> _user = Rxn<User>();

  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  AuthState get getAuthState => _authState.value;
  set setAuthState(AuthState state) {
    _authState.value = state;
  }

  PageState get getPageState => _pageState.value;
  set setPageState(PageState state) {
    _pageState.value = state;
  }

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
          setAuthState = AuthState.loggedIn;
        }
      } else {
        if (Get.currentRoute != "/WelcomePage") {
          Get.offAll(() => const WelcomePage());
          setAuthState = AuthState.notLoggedIn;
        }
      }
    });
  }
  final FirebaseAuth auth = FirebaseAuth.instance;

  void setLoginPage() => setPageState = PageState.login;
  void setRegisterPage() => setPageState = PageState.register;
  void setWelcomePage() => setPageState = PageState.welcome;

  Future<void> tappedBottomButton() async {
    try {
      if (getPageState == PageState.register) {
        setAuthState = AuthState.loading;
        await auth.createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim());
      } else if (getPageState == PageState.login) {
        setAuthState = AuthState.loading;

        await auth.signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim());
      } else {
        setLoginPage();
      }
    } on FirebaseAuthException catch (e) {
      setAuthState = AuthState.notLoggedIn;

      Get.snackbar("OOOPPPSSS", e.message.toString(),
          colorText: Color.fromARGB(255, 65, 227, 75));
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
