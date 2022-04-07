class AppConstans{
  static AppConstans? _instance;
  static   AppConstans get instance{
    _instance ??= AppConstans._init();
    return _instance!;

  }
  AppConstans._init(){
    BACKGROUND_IMAGE ="assets/bg.jpeg";
  }

  late final String BACKGROUND_IMAGE;
}