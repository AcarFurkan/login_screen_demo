part of '../welcome_page.dart';

extension WelcomePageExtension on _WelcomePageState {
  Container buildDivider(double height, double width) => Container(
      height: height / 150,
      width: width / 5,
      decoration: BoxDecoration(
          color: Get.isDarkMode ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(15)));
  Container buildmainAnimatedContainer(double height, double width) =>
      Container(
        color: Get.isDarkMode ? Colors.black87 : Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: buildLoginRegisterColumn(height),
        ),
        width: width,
        height: (pageController.getPageState == PageState.login ||
                pageController.getPageState == PageState.register)
            ? height * 0.7
            : 0,
      );

  Column buildLoginRegisterColumn(double height) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          Expanded(flex: 2, child: buildLoginText),
          Expanded(
              flex: 2,
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: height / 150),
                  child: buildSignYourAccountText)),
          const Spacer(),
          buildAnimatedTextFormField(height),
          Expanded(
              flex: 4,
              child: inputGenerator(
                  infoText: email, controller: pageController.emailController)),
          Expanded(
              flex: 4,
              child: inputGenerator(
                  infoText: password,
                  controller: pageController.passwordController,
                  isPassword: true)),
          Expanded(flex: 2, child: buildForgotPasswordButton),
          const Spacer(flex: 7), //BUNU KLAVYE AÇILINCA İPTAL ET EFSO OLUR
          Expanded(flex: 2, child: buildldontHaveAcountTextButton)
        ],
      );

  Text get buildLoginText => Text(
        pageController.getPageState == PageState.login ? login : register,
        style: GoogleFonts.playfairDisplay(
            textStyle: Theme.of(context).textTheme.headline4!.apply(
                fontWeightDelta: 2,
                color: Get.isDarkMode ? Colors.white : Colors.black)),
      );

  Text get buildSignYourAccountText => Text(
      pageController.getPageState == PageState.login
          ? welcomeButtonText
          : createYourAccount,
      style: GoogleFonts.playfairDisplay(
          textStyle: Theme.of(context)
              .textTheme
              .headline5!
              .apply(color: Get.isDarkMode ? Colors.white : Colors.black)));

  AnimatedContainer buildAnimatedTextFormField(double height) =>
      AnimatedContainer(
          curve: Curves.decelerate,
          height: pageController.getPageState == PageState.register
              ? height / 9
              : 0,
          child: AnimatedPadding(
            duration: Duration(milliseconds: 750),
            padding: EdgeInsets.symmetric(
              vertical: pageController.getPageState == PageState.register
                  ? height / 100
                  : 0,
            ),
            child: AnimatedOpacity(
                duration: Duration(milliseconds: 750),
                opacity:
                    pageController.getPageState == PageState.register ? 1 : 0,
                child: inputGenerator(
                    infoText: name, controller: pageController.nameController)),
          ),
          duration: const Duration(milliseconds: 750));
  TextButton get buildForgotPasswordButton => TextButton(
      style:
          ButtonStyle(overlayColor: MaterialStateProperty.all(Colors.white10)),
      onPressed: () {},
      child: Text(
        forgotPassword,
        style: GoogleFonts.openSans(
            fontWeight: FontWeight.bold,
            textStyle:
                Theme.of(context).textTheme.bodyText1!.apply(fontSizeDelta: 2)),
      ));
  Center get buildldontHaveAcountTextButton => Center(
      child: TextButton(
          style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.white10)),
          onPressed: () => pageController.tappedisHaveAccountButton(),
          child: Text(
            pageController.getPageState == PageState.login
                ? dontHaveAccount
                : haveAccount,
            style: GoogleFonts.openSans(
                textStyle: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .apply(fontSizeDelta: 2)),
          )));
           Column inputGenerator({
    required String infoText,
    required TextEditingController controller,
    bool isPassword = false,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: buildInputColumnText(infoText),
          ),
          const Spacer(),
          Expanded(
              flex: 7, child: buildInputTextFormField(isPassword, controller)),
        ],
      );

  Text buildInputColumnText(String infoText) => Text(infoText,
      style: GoogleFonts.openSans(
          fontWeight: FontWeight.w600,
          fontSize: 15,
          textStyle: Theme.of(context).textTheme.bodyText1!.apply()));

  TextFormField buildInputTextFormField(
          bool isPassword, TextEditingController controller) =>
      TextFormField(
        decoration: InputDecoration(
            suffixIcon: isPassword
                ? IconButton(
                    onPressed: () {
                      pageController.changeObscureText;
                    },
                    icon: Icon(
                      pageController.isObscureText == true
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey,
                    ))
                : const SizedBox()),
        obscureText: isPassword ? pageController.isObscureText : false,
        controller: controller,
      );

}
