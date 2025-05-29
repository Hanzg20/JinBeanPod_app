import 'package:get/get.dart';

class AuthController extends GetxController {
  final RxBool _isLoggedIn = false.obs;
  bool get isLoggedIn => _isLoggedIn.value;

  // 模拟登录
  Future<void> login() async {
    _isLoggedIn.value = true;
  }

  // 模拟登出
  Future<void> logout() async {
    _isLoggedIn.value = false;
  }
} 