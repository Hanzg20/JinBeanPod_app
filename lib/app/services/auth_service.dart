import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../core/config/supabase_config.dart';

class AuthService extends GetxService {
  late final SupabaseClient _supabase;
  
  final _isAuthenticated = false.obs;
  bool get isAuthenticated => _isAuthenticated.value;
  
  final _user = Rx<User?>(null);
  User? get currentUser => _user.value;

  @override
  void onInit() {
    super.onInit();
    _supabase = Supabase.instance.client;
    
    // 监听认证状态变化
    _supabase.auth.onAuthStateChange.listen((data) {
      _user.value = data.session?.user;
      _isAuthenticated.value = data.session != null;
    });
  }

  Future<AuthResponse> signInWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: SupabaseConfig.appleClientId,
          redirectUri: Uri.parse(SupabaseConfig.appleRedirectUrl),
        ),
      );

      final response = await _supabase.auth.signInWithIdToken(
        provider: OAuthProvider.apple,
        idToken: credential.identityToken!,
      );
      return response;
    } catch (e) {
      print('Apple登录失败: $e');
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
    } catch (e) {
      print('登出失败: $e');
      rethrow;
    }
  }

  // 获取用户资料
  Future<Map<String, dynamic>?> getUserProfile() async {
    try {
      if (!isAuthenticated) return null;
      final userId = currentUser?.id;
      if (userId == null) return null;
      
      final response = await _supabase
          .from('profiles')
          .select()
          .eq('id', userId)
          .single();
          
      return response;
    } catch (e) {
      print('获取用户资料失败: $e');
      return null;
    }
  }

  // 更新用户资料
  Future<void> updateUserProfile(Map<String, dynamic> data) async {
    try {
      if (!isAuthenticated) return;
      final userId = currentUser?.id;
      if (userId == null) return;
      
      await _supabase
          .from('profiles')
          .upsert({
            'id': userId,
            ...data,
            'updated_at': DateTime.now().toIso8601String(),
          });
    } catch (e) {
      print('更新用户资料失败: $e');
      rethrow;
    }
  }

  // 邮箱登录
  Future<AuthResponse> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response;
    } catch (e) {
      print('邮箱登录失败: $e');
      rethrow;
    }
  }

  // 邮箱注册
  Future<AuthResponse> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: <String, String>{'display_name': displayName ?? ''},
      );
      return response;
    } catch (e) {
      print('邮箱注册失败: $e');
      rethrow;
    }
  }

  // 重置密码
  Future<void> resetPassword(String email) async {
    try {
      await _supabase.auth.resetPasswordForEmail(email);
    } catch (e) {
      print('重置密码失败: $e');
      rethrow;
    }
  }

  // --- 以下为未实现的占位方法 ---
  Future<void> signInWithGoogle() async {
    throw UnimplementedError('Google 登录暂未实现');
  }
  Future<void> signInWithWeChat() async {
    throw UnimplementedError('微信登录暂未实现');
  }
  //Future<Map<String, dynamic>?> getCurrentUserProfile() async {
  //  throw UnimplementedError('获取用户资料暂未实现');
  //}
 // Future<AuthResponse> loginWithEmail({required String email, required String password}) async {
 //   throw UnimplementedError('邮箱登录暂未实现');
 // }
 // Future<AuthResponse> registerWithEmail({required String email, required String password, required String displayName}) async {
  //  throw UnimplementedError('邮箱注册暂未实现');
  //}
 // Future<void> sendPasswordResetEmail(String email) async {
 //   throw UnimplementedError('重置密码暂未实现');
  //}
} 