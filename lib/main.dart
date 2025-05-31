import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app/routes/app_pages.dart';
import 'app/app.dart';
import 'core/config/supabase_config.dart';
import 'app/services/auth_service.dart';
import 'app/controllers/auth_controller.dart';
import 'features/main/controllers/main_controller.dart';
import 'core/translations/app_translations.dart';
import 'core/controllers/settings_controller.dart';
import 'core/controllers/language_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    // 初始化 Supabase
    await Supabase.initialize(
      url: SupabaseConfig.url,
      anonKey: SupabaseConfig.anonKey,
    );
    
    // 初始化 SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    Get.put(prefs, permanent: true);

    // 初始化 AuthService 和 AuthController
    Get.put(AuthService(), permanent: true);
    Get.put(AuthController(), permanent: true);
    
    // 初始化 MainController
    Get.put(MainController(), permanent: true);

    // 初始化 SettingsController
    Get.put(SettingsController(), permanent: true);

    // 初始化 LanguageController
    Get.put(LanguageController(), permanent: true);

    runApp(const App());
  } catch (e) {
    debugPrint('Error during initialization: $e');
    rethrow;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: '金豆荚',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            useMaterial3: true,
          ),
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          defaultTransition: Transition.fadeIn,
          translations: AppTranslations(),
          locale: const Locale('zh', 'CN'),
          fallbackLocale: const Locale('en', 'US'),
        );
      },
    );
  }
}
