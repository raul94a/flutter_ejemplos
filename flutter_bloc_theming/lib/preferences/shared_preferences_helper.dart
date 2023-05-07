import 'package:shared_preferences/shared_preferences.dart';

///singleton pattern
///
///SharedPrefences can be instanciated in two different ways
///
///```dart
/// //1. async initialization of SharedPrefences (first time you call it). Cannot await to its initialization  
/// final preferences = SharedPreferencesHelper.instance
/// 
/// //2. async initialization of SharedPreferences (first tiem you call it). You can await to its initialization
/// final preferences = await SharedPreferencesHelpder.init()
/// 
/// 
///```
///It's preferable to call the init method in the main function of the app.
///
///After that, you can access the SharedPreferences with SharedPreferencesHelper.instance with no problem
class SharedPreferencesHelper {
  //constructors
  SharedPreferencesHelper._internal() {
    SharedPreferences.getInstance().then((value) => _preferences = value);
  }
  SharedPreferencesHelper._init();
  //static variables & getters
  static SharedPreferences? _preferences;
  SharedPreferences get preferences => _preferences!;
  static SharedPreferencesHelper? _instance;
  static SharedPreferencesHelper get instance =>
      _instance ??= SharedPreferencesHelper._internal();

  //async init method to be called in the main method of the app
  static Future<SharedPreferencesHelper> init() async {
    if (_instance != null) {
      return _instance!;
    }
    final prefs = await SharedPreferences.getInstance();
    _preferences = prefs;
    _instance = SharedPreferencesHelper._init();
    return _instance!;
  }

  //Keys for our preferences
  static const String _theme = "THEME";

  //true => light
  //false => dark
  bool getTheme() {
    return preferences.getBool(_theme) ?? true;
  }

  void setTheme(bool lightTheme) {
    preferences.setBool(_theme, lightTheme);
  }

  ///rest of preferences
}
