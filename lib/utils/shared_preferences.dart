import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  late SharedPreferences _prefs;

  static final Preferences _instance = Preferences._();

  Preferences._();

  factory Preferences() {
    return _instance;
  }

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void setUid(String? accessToken) {
    _prefs.setString("uid", accessToken ?? '');
  }

  String getUid() {
    return _prefs.getString("uid") ?? "";
  }

  void clearSharedPrefs() {
    _prefs.clear();
  }
}
