import 'package:flutter/material.dart';
import 'package:flutter_login_ui_demo/core/constants.dart';
import 'package:flutter_login_ui_demo/core/enums/auth_state_enum.dart';
import 'package:flutter_login_ui_demo/core/enums/page_state_enum.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/page_controller.dart';
part './extensions/welcome_page_extension.dart';

class WelcomePage extends StatefulWidget {
  //It remained stateful because I was too lazy to give contexts manually.
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final String welcomeButtonText = "Sign To Your Account";
  final String createYourAccount = "Create Your Account";
  final String herbalova = "Herbalova";
  final String login = "Login";
  final String register = "Register";
  final String email = "EMAIL";
  final String password = "PASSWORD";
  final String name = "NAME";
  final String dontHaveAccount = "I dont have an account";
  final String haveAccount = "I have an account";
  final String forgotPassword = "Forgot Password?";

  final PageStateController pageController = Get.put(PageStateController());

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Stack(children: [
      buildBackground,
      buildHerbalovaText,
      buildLoginRegisterContainer(height, width),
      buildBottomButton(width, height),
      Obx((() => pageController.getAuthState == AuthState.loading
          ? Positioned(
              child: const CircularProgressIndicator.adaptive( ), top: height / 2,left: (width/2)-10,)
          : Container()))
    ]));
  }

  Image get buildBackground => Image.asset(
        AppConstans.instance.BACKGROUND_IMAGE,
        fit: BoxFit.fill,
        height: (MediaQuery.of(context).size.height),
      );

  Obx get buildHerbalovaText =>
      Obx((() => pageController.getPageState == PageState.welcome
          ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Center(
                  child: Text(herbalova,
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .apply(color: Colors.white)))
            ])
          : Container()));

  Obx buildLoginRegisterContainer(double height, double width) =>
      Obx((() => Positioned(
            bottom: height / 15,
            child: AnimatedSize(
              curve: Curves.decelerate,
              duration: Duration(seconds: 1),
              child: Column(
                children: [
                  buildDivider(height, width),
                  SizedBox(height: height / 85),
                  buildmainAnimatedContainer(height, width),
                ],
              ),
            ),
          )));

  Obx buildBottomButton(double width, double height) => Obx(
        () => Positioned(
            bottom: 0,
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        pageController.getPageState == PageState.welcome
                            ? (Get.isDarkMode ? Colors.black : Colors.white)
                            : Colors.green),
                    minimumSize:
                        MaterialStateProperty.all(Size(width, height / 15))),
                onPressed: () => pageController.tappedBottomButton(),
                child: buildBottomButtonText)),
      );

  Obx get buildBottomButtonText => Obx(() => Text(
        pageController.getPageState == PageState.welcome
            ? welcomeButtonText
            : pageController.getPageState == PageState.login
                ? login
                : register,
        style: Theme.of(context).textTheme.headline6!.apply(),
      ));
}
