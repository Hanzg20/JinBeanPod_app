import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService extends GetxService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  Rx<User?> currentUser = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    // 监听用户状态变化
    _auth.authStateChanges().listen((User? user) {
      currentUser.value = user;
      if (user != null) {
        _updateUserData(user);
      }
    });
  }

  // Google 登录
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      await _updateUserData(userCredential.user!, provider: 'google');
      return userCredential;
    } catch (e) {
      print('Google sign in error: $e');
      return null;
    }
  }

  // Apple 登录
  Future<UserCredential?> signInWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      final userCredential = await _auth.signInWithCredential(oauthCredential);
      await _updateUserData(userCredential.user!, provider: 'apple');
      return userCredential;
    } catch (e) {
      print('Apple sign in error: $e');
      return null;
    }
  }

  // 微信登录
  Future<void> signInWithWeChat() async {
    // TODO: 实现微信登录
    // 需要集成微信SDK
  }

  // 更新用户数据
  Future<void> _updateUserData(User user, {String? provider}) async {
    final userData = {
      'email': user.email,
      'updated_at': FieldValue.serverTimestamp(),
      'last_login': FieldValue.serverTimestamp(),
    };

    if (provider != null) {
      userData['auth_providers'] = FieldValue.arrayUnion([
        {
          'provider': provider,
          'provider_uid': user.uid,
          'email': user.email,
          'connected_at': FieldValue.serverTimestamp(),
        }
      ]);
    }

    // 更新用户文档
    await _firestore.collection('users').doc(user.uid).set(
      userData,
      SetOptions(merge: true),
    );

    // 确保用户配置文件存在
    final profileDoc = await _firestore.collection('user_profiles').doc(user.uid).get();
    if (!profileDoc.exists) {
      await _firestore.collection('user_profiles').doc(user.uid).set({
        'user_id': user.uid,
        'display_name': user.displayName ?? '',
        'avatar_url': user.photoURL ?? '',
        'created_at': FieldValue.serverTimestamp(),
        'preferences': {
          'notification': {
            'push_enabled': true,
            'email_enabled': true,
            'sms_enabled': true,
          },
          'privacy': {
            'profile_visible': true,
            'show_online': true,
          }
        }
      });
    }
  }

  // 退出登录
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  // 获取当前用户资料
  Future<Map<String, dynamic>?> getCurrentUserProfile() async {
    if (currentUser.value == null) return null;
    
    final doc = await _firestore
        .collection('user_profiles')
        .doc(currentUser.value!.uid)
        .get();
        
    return doc.data();
  }

  // 更新用户资料
  Future<void> updateUserProfile(Map<String, dynamic> data) async {
    if (currentUser.value == null) return;
    
    await _firestore
        .collection('user_profiles')
        .doc(currentUser.value!.uid)
        .update(data);
  }
} 