import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsController extends GetxController {
  final _box = GetStorage();
  final _themeMode = ThemeMode.system.obs;
  final _locale = const Locale('zh', 'CN').obs;

  ThemeMode get themeMode => _themeMode.value;
  Locale get currentLocale => _locale.value;
  bool get isDarkMode => _themeMode.value == ThemeMode.dark;

  @override
  void onInit() {
    super.onInit();
    loadSettings();
  }

  Future<void> loadSettings() async {
    final savedThemeMode = _box.read('themeMode') ?? 'system';
    final savedLanguage = _box.read('language') ?? 'zh_CN';
    
    await updateTheme(savedThemeMode);
    await updateLocale(savedLanguage);
  }

  Future<void> updateTheme(String mode) async {
    await _box.write('themeMode', mode);
    switch (mode) {
      case 'light':
        _themeMode.value = ThemeMode.light;
        break;
      case 'dark':
        _themeMode.value = ThemeMode.dark;
        break;
      default:
        _themeMode.value = ThemeMode.system;
    }
  }

  Future<void> updateLocale(String languageCode) async {
    await _box.write('language', languageCode);
    switch (languageCode) {
      case 'en_US':
        _locale.value = const Locale('en', 'US');
        break;
      case 'zh_CN':
        _locale.value = const Locale('zh', 'CN');
        break;
      default:
        _locale.value = Get.deviceLocale ?? const Locale('zh', 'CN');
    }
  }
} 