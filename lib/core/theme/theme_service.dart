import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService {
  final _key = 'isDarkMode';

  ThemeMode get theme =>
      _loadThemeFromDisk() ? ThemeMode.dark : ThemeMode.light;

  bool _loadThemeFromDisk() {
    final prefs = Get.find<SharedPreferences>();
    return prefs.getBool(_key) ?? true;
  }

  void switchTheme() {
    Get.changeThemeMode(
        _loadThemeFromDisk() ? ThemeMode.light : ThemeMode.dark);
    _saveThemeToDisk(!_loadThemeFromDisk());
  }

  Future<void> _saveThemeToDisk(bool isDarkMode) async {
    final prefs = Get.find<SharedPreferences>();
    await prefs.setBool(_key, isDarkMode);
  }
}
