import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'core/controllers/settings_controller.dart';
import 'core/translations/translations.dart' as app_translations;
import 'features/main/views/main_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  
  // 初始化设置控制器
  final settingsController = Get.put(SettingsController());
  await settingsController.loadSettings();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsController = Get.find<SettingsController>();

    return Obx(() => GetMaterialApp(
      title: 'JinDouJia Services',
      translations: app_translations.AppTranslations(),
      locale: settingsController.currentLocale,
      fallbackLocale: const Locale('zh', 'CN'),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: settingsController.themeMode,
      home: const MainPage(),
    ));
  }
}
