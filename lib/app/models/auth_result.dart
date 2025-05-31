import 'package:firebase_auth/firebase_auth.dart';

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