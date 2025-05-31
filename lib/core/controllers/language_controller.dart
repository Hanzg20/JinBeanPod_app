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
    final prefs = Get.find<SharedPreferences>();
    final savedLanguage = prefs.getString(languageKey);
    
    debugPrint('LanguageController: Loaded saved language: $savedLanguage'); // Debug print

    String languageToApply = 'zh_CN'; // Default to Chinese

    if (savedLanguage != null && languages.any((lang) => lang['code'] == savedLanguage)) {
      // If a valid language is saved, use it
      languageToApply = savedLanguage;
    }

    debugPrint('LanguageController: Applying language: $languageToApply'); // Debug print

    // Apply the language and save it if it was the default
    await updateLanguage(languageToApply);
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