import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';

class AuthController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  
  final Rx<bool> isLoading = false.obs;
  final Rx<String> errorMessage = ''.obs;

  // 用户状态
  Rx<User?> get user => _authService.currentUser;
  bool get isLoggedIn => user.value != null;

  // Google 登录
  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      
      final result = await _authService.signInWithGoogle();
      if (result == null) {
        errorMessage.value = '登录失败，请重试';
      }
    } catch (e) {
      errorMessage.value = '登录过程中出现错误：$e';
    } finally {
      isLoading.value = false;
    }
  }

  // Apple 登录
  Future<void> signInWithApple() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      
      final result = await _authService.signInWithApple();
      if (result == null) {
        errorMessage.value = '登录失败，请重试';
      }
    } catch (e) {
      errorMessage.value = '登录过程中出现错误：$e';
    } finally {
      isLoading.value = false;
    }
  }

  // 微信登录
  Future<void> signInWithWeChat() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      
      await _authService.signInWithWeChat();
    } catch (e) {
      errorMessage.value = '登录过程中出现错误：$e';
    } finally {
      isLoading.value = false;
    }
  }

  // 退出登录
  Future<void> signOut() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      
      await _authService.signOut();
    } catch (e) {
      errorMessage.value = '退出登录时出现错误：$e';
    } finally {
      isLoading.value = false;
    }
  }

  // 获取用户资料
  Future<Map<String, dynamic>?> getUserProfile() async {
    try {
      return await _authService.getCurrentUserProfile();
    } catch (e) {
      errorMessage.value = '获取用户资料失败：$e';
      return null;
    }
  }

  // 更新用户资料
  Future<void> updateUserProfile(Map<String, dynamic> data) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      
      await _authService.updateUserProfile(data);
    } catch (e) {
      errorMessage.value = '更新用户资料失败：$e';
    } finally {
      isLoading.value = false;
    }
  }
} 