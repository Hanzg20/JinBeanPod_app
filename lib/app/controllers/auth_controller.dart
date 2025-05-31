import 'package:get/get.dart';
import '../services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../routes/app_pages.dart';

class AuthController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  final SharedPreferences _prefs = Get.find<SharedPreferences>();
  
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  
  final _isAuthenticated = false.obs;
  bool get isAuthenticated => _isAuthenticated.value;
  
  final _errorMessage = ''.obs;
  String get errorMessage => _errorMessage.value;
  
  final _isGuest = false.obs;
  bool get isGuest => _isGuest.value;

  // 表单数据
  String email = '';
  String password = '';
  String confirmPassword = '';
  String displayName = '';

  // 用户状态
  User? get user => _authService.currentUser;
  bool get isLoggedIn => user != null || isGuest;

  @override
  void onInit() {
    super.onInit();
    _isAuthenticated.value = _authService.isAuthenticated;
    _isGuest.value = _prefs.getBool('is_guest_mode') ?? false;
  }

  Future<void> signInWithApple() async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';
      
      await _authService.signInWithApple();
      _isAuthenticated.value = _authService.isAuthenticated;
      
      // 清除游客模式标志
      await _prefs.setBool('is_guest_mode', false);
      _isGuest.value = false;
      
      // 导航到主页
      Get.offAllNamed(Routes.MAIN);
    } catch (e) {
      _errorMessage.value = '登录失败: $e';
      rethrow;
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    try {
      _isLoading.value = true;
      await _authService.signOut();
      _isAuthenticated.value = _authService.isAuthenticated;
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      _errorMessage.value = '退出登录失败: $e';
      rethrow;
    } finally {
      _isLoading.value = false;
    }
  }

  void continueAsGuest() async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';
      
      // 设置游客模式标志
      await _prefs.setBool('is_guest_mode', true);
      _isGuest.value = true;
      
      // 跳转到主页面
      Get.offAllNamed(Routes.MAIN);
    } catch (e) {
      _errorMessage.value = '无法使用游客模式，请稍后重试';
    } finally {
      _isLoading.value = false;
    }
  }

  // Google 登录
  Future<void> signInWithGoogle() async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';
      
      await _authService.signInWithGoogle();

      // 清除游客模式标志
      await _prefs.setBool('is_guest_mode', false);
      _isGuest.value = false;

      // 导航到主页
      _isAuthenticated.value = _authService.isAuthenticated;
      Get.offAllNamed(Routes.MAIN);
    } catch (e) {
      _errorMessage.value = '登录过程中出现错误：$e';
    } finally {
      _isLoading.value = false;
    }
  }

  // 微信登录
  Future<void> signInWithWeChat() async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';
      
      await _authService.signInWithWeChat();

      // 清除游客模式标志
      await _prefs.setBool('is_guest_mode', false);
      _isGuest.value = false;

      // 导航到主页
      _isAuthenticated.value = _authService.isAuthenticated;
      Get.offAllNamed(Routes.MAIN);
    } catch (e) {
      _errorMessage.value = '登录过程中出现错误：$e';
    } finally {
      _isLoading.value = false;
    }
  }

  // 获取用户资料
  Future<Map<String, dynamic>?> getUserProfile() async {
    try {
      if (isGuest) return null;
      return await _authService.getUserProfile();
    } catch (e) {
      _errorMessage.value = '获取用户资料失败：$e';
      return null;
    }
  }

  // 更新用户资料
  Future<void> updateUserProfile(Map<String, dynamic> data) async {
    try {
      if (isGuest) return;
      
      _isLoading.value = true;
      _errorMessage.value = '';
      
      await _authService.updateUserProfile(data);
    } catch (e) {
      _errorMessage.value = '更新用户资料失败：$e';
    } finally {
      _isLoading.value = false;
    }
  }

  // 邮箱登录
  Future<void> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      debugPrint('Attempting to login with email: $email');
      _isLoading.value = true;
      _errorMessage.value = '';
      
      final result = await _authService.signInWithEmail(
        email: email,
        password: password,
      );
      
      if (result.session != null) {
        debugPrint('Login successful for email: $email');
        // 清除游客模式标志
        await _prefs.setBool('is_guest_mode', false);
        _isGuest.value = false;
        _isAuthenticated.value = _authService.isAuthenticated;
        Get.offAllNamed(Routes.MAIN);
      } else {
        debugPrint('Login failed for email: $email, result: \${result.toString()}');
        _errorMessage.value = '登录失败';
      }
    } catch (e) {
      debugPrint('Unexpected error during login: $e');
      _errorMessage.value = '登录失败，请稍后重试';
    } finally {
      _isLoading.value = false;
    }
  }

  // 邮箱注册
  Future<void> registerWithEmail({
    required String email,
    required String password,
    required String displayName,
  }) async {
    try {
      debugPrint('Attempting to register with email: $email');
      _isLoading.value = true;
      _errorMessage.value = '';
      
      final result = await _authService.signUpWithEmail(
        email: email,
        password: password,
        displayName: displayName,
      );
      
      if (result.session != null) {
        debugPrint('Registration successful for email: $email');
        // 清除游客模式标志
        await _prefs.setBool('is_guest_mode', false);
        _isGuest.value = false;
        _isAuthenticated.value = _authService.isAuthenticated;
        Get.offAllNamed(Routes.MAIN);
      } else {
        debugPrint('Registration failed for email: $email, result: \${result.toString()}');
        _errorMessage.value = '注册失败';
      }
    } catch (e) {
      debugPrint('Unexpected error during registration: $e');
      _errorMessage.value = '注册失败，请稍后重试';
    } finally {
      _isLoading.value = false;
    }
  }

  // 重置密码
  Future<void> resetPassword(String email) async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';
      
      await _authService.resetPassword(email);
      Get.snackbar(
        '重置密码',
        '重置密码邮件已发送，请查收',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      _errorMessage.value = '发送重置密码邮件失败：$e';
    } finally {
      _isLoading.value = false;
    }
  }
} 