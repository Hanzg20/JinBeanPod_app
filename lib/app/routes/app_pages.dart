import 'package:get/get.dart';
import '../../features/auth/views/auth_page.dart';
import '../../features/auth/views/email_auth_page.dart';
import '../../features/jindou/views/jindou_page.dart';
import '../../features/auth/views/login_page.dart';
import '../../features/main/views/main_page.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: Routes.AUTH,
      page: () => const AuthPage(),
    ),
    GetPage(
      name: Routes.EMAIL_AUTH,
      page: () => const EmailAuthPage(),
    ),
    GetPage(
      name: Routes.MAIN,
      page: () => const MainPage(),
    ),
  ];
} 