import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthResult {
  final bool success;
  final String? error;
  final UserCredential? userCredential;

  AuthResult({
    required this.success,
    this.error,
    this.userCredential,
  });
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _imagePicker = ImagePicker();
  
  // Email Registration
  Future<AuthResult> registerWithEmail({
    required String email,
    required String password,
    required String displayName,
  }) async {
    try {
      // Validate email format
      if (!_isValidEmail(email)) {
        return AuthResult(
          success: false,
          error: '请输入有效的电子邮件地址',
        );
      }

      // Validate password strength
      String? passwordError = _validatePassword(password);
      if (passwordError != null) {
        return AuthResult(
          success: false,
          error: passwordError,
        );
      }

      // Create user account
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update display name
      await userCredential.user?.updateDisplayName(displayName);

      // Create user profile in Firestore
      await _createUserProfile(userCredential.user!.uid, {
        'email': email,
        'displayName': displayName,
        'createdAt': FieldValue.serverTimestamp(),
        'lastLoginAt': FieldValue.serverTimestamp(),
        'emailVerified': false,
        'photoURL': null,
        'phoneNumber': null,
        'address': null,
        'bio': null,
      });

      // Send email verification
      await userCredential.user?.sendEmailVerification();

      return AuthResult(
        success: true,
        userCredential: userCredential,
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage = _getFirebaseAuthErrorMessage(e.code);
      return AuthResult(
        success: false,
        error: errorMessage,
      );
    } catch (e) {
      return AuthResult(
        success: false,
        error: '注册过程中发生错误，请稍后重试',
      );
    }
  }

  // Create user profile in Firestore
  Future<void> _createUserProfile(String uid, Map<String, dynamic> data) async {
    try {
      await _firestore.collection('users').doc(uid).set(data);
    } catch (e) {
      debugPrint('Error creating user profile: $e');
      // 虽然创建 profile 失败，但不影响注册流程
    }
  }

  // Get user profile from Firestore
  Future<Map<String, dynamic>?> getUserProfile(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      return doc.data();
    } catch (e) {
      debugPrint('Error getting user profile: $e');
      return null;
    }
  }

  // Update user profile
  Future<bool> updateUserProfile(String uid, Map<String, dynamic> data) async {
    try {
      await _firestore.collection('users').doc(uid).update(data);
      return true;
    } catch (e) {
      debugPrint('Error updating user profile: $e');
      return false;
    }
  }

  // Google Sign In Web Flow
  Future<AuthResult> signInWithGoogle(BuildContext context) async {
    try {
      // Create a new provider
      GoogleAuthProvider googleProvider = GoogleAuthProvider();
      
      // Add scopes as needed
      googleProvider.addScope('email');
      googleProvider.addScope('profile');
      
      // Start the sign in process
      final UserCredential userCredential = await _auth.signInWithPopup(googleProvider);
      
      return AuthResult(
        success: true,
        userCredential: userCredential,
      );
    } catch (e) {
      debugPrint('Error during Google sign in: $e');
      return AuthResult(
        success: false,
        error: '使用Google登录时发生错误，请稍后重试',
      );
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Auth state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Check if user email is verified
  bool get isEmailVerified => _auth.currentUser?.emailVerified ?? false;

  // Send verification email
  Future<void> sendVerificationEmail() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } catch (e) {
      throw '发送验证邮件失败，请稍后重试';
    }
  }

  // Validate email format
  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  // Validate password strength
  String? _validatePassword(String password) {
    if (password.length < 8) {
      return '密码长度必须至少为8个字符';
    }
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return '密码必须包含至少一个大写字母';
    }
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return '密码必须包含至少一个小写字母';
    }
    if (!RegExp(r'[0-9]').hasMatch(password)) {
      return '密码必须包含至少一个数字';
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      return '密码必须包含至少一个特殊字符';
    }
    return null;
  }

  // Get localized error message
  String _getFirebaseAuthErrorMessage(String code) {
    switch (code) {
      case 'email-already-in-use':
        return '该邮箱已被注册';
      case 'invalid-email':
        return '无效的电子邮件地址';
      case 'operation-not-allowed':
        return '邮箱注册功能未启用';
      case 'weak-password':
        return '密码强度太弱';
      case 'network-request-failed':
        return '网络连接失败';
      case 'too-many-requests':
        return '请求次数过多，请稍后重试';
      default:
        return '注册失败，请稍后重试';
    }
  }

  // Pick image from gallery or camera
  Future<XFile?> pickImage({required bool fromCamera}) async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: fromCamera ? ImageSource.camera : ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 80,
      );
      return image;
    } catch (e) {
      debugPrint('Error picking image: $e');
      return null;
    }
  }

  // Upload avatar image
  Future<String?> uploadAvatar(XFile imageFile) async {
    try {
      final user = _auth.currentUser;
      if (user == null) return null;

      // 获取文件大小
      final file = File(imageFile.path);
      final fileSize = await file.length();
      
      // 如果文件大于 2MB，返回错误
      if (fileSize > 2 * 1024 * 1024) {
        throw '图片大小不能超过2MB';
      }

      // Create a reference to the avatar image in Firebase Storage
      final ref = _storage.ref().child('avatars/${user.uid}/${DateTime.now().millisecondsSinceEpoch}.jpg');

      // Upload the file with metadata
      final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {
          'userId': user.uid,
          'uploadedAt': DateTime.now().toIso8601String(),
        },
      );
      
      final uploadTask = await ref.putFile(file, metadata);

      // Get the download URL
      final downloadUrl = await uploadTask.ref.getDownloadURL();

      // Update user profile
      await user.updatePhotoURL(downloadUrl);
      await updateUserProfile(user.uid, {
        'photoURL': downloadUrl,
        'lastUpdated': FieldValue.serverTimestamp(),
      });

      return downloadUrl;
    } catch (e) {
      debugPrint('Error uploading avatar: $e');
      rethrow;  // 重新抛出异常，让调用者处理具体错误
    }
  }

  // Delete old avatar
  Future<void> deleteOldAvatar(String photoURL) async {
    try {
      if (photoURL.startsWith('https://firebasestorage.googleapis.com')) {
        final ref = FirebaseStorage.instance.refFromURL(photoURL);
        await ref.delete();
      }
    } catch (e) {
      debugPrint('Error deleting old avatar: $e');
    }
  }
} 