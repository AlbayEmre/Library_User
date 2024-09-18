import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  static const Theme_status = "THEME_STATUS"; //tehema yı keydetmek için key (key:value) tipi oldundan
  bool _darkTheme = false;
  bool get getIsDerkTehme => _darkTheme;

  ThemeProvider() {
    getTheme();
  }

  setDarkTheme({required bool tehemeValue}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(Theme_status, tehemeValue);
    _darkTheme = tehemeValue;
    notifyListeners(); //Bu deyişikliği tüm ekranlar dinelyecek o yüzen  notifyListeners()  yazdık
  }

  //! Kukkanıcının tema ile ilgili bir deyişikliği varmı bak
  //?Hafızada kaydedilen theme varmı "Theme_status" burda key
  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _darkTheme = prefs.getBool(Theme_status) ?? false;
    notifyListeners(); //Burdaki tema deyişimi de tüm ekranlarda olacağından notifyListeners() olacak
    return _darkTheme;
  }
}
