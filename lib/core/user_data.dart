import 'package:nb_utils/nb_utils.dart';

class UserData {
  Future<bool> getIsDarkMode() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool('darkMode') ?? false;
  }

  Future setDarkMode(bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('darkMode', value);
  }

  Future<bool> getLanguage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool('lang') ?? false;
  }

  Future setLanguage(bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('lang', value);
  }

  Future<bool> getisNewInstall() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool('newInstall') ?? true;
  }

  Future setNewInstall() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('newInstall', false);
  }
}
