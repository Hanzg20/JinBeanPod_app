import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageController extends GetxController {
  static const String languageKey = 'selectedLanguage';
  final RxString currentLanguage = 'zh_CN'.obs;

  // 支持的语言列表
  final List<Map<String, dynamic>> languages = [
    {
      'name': '简体中文',
      'locale': const Locale('zh', 'CN'),
      'code': 'zh_CN',
    },
    {
      'name': 'English',
      'locale': const Locale('en', 'US'),
      'code': 'en_US',
    },
    {
      'name': 'Français',
      'locale': const Locale('fr', 'FR'),
      'code': 'fr_FR',
    },
  ];

  Locale get currentLocale {
    final languageMap = languages.firstWhere(
      (lang) => lang['code'] == currentLanguage.value,
      orElse: () => languages[0],
    );
    return languageMap['locale'] as Locale;
  }

  @override
  void onInit() {
    super.onInit();
    loadSelectedLanguage();
  }

  Future<void> loadSelectedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLanguage = prefs.getString(languageKey);
    if (savedLanguage != null) {
      currentLanguage.value = savedLanguage;
      await updateLanguage(savedLanguage);
    }
  }

  Future<void> updateLanguage(String languageCode) async {
    final locale = Locale(
      languageCode.split('_')[0],
      languageCode.split('_')[1],
    );
    Get.updateLocale(locale);
    currentLanguage.value = languageCode;
    await saveSelectedLanguage(languageCode);
  }

  Future<void> saveSelectedLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(languageKey, languageCode);
  }

  // 获取当前语言名称
  String getCurrentLanguageName() {
    return languages
        .firstWhere(
          (lang) => lang['locale'] == currentLocale,
          orElse: () => languages[0],
        )['name'];
  }
} 