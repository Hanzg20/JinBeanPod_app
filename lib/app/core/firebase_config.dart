import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class FirebaseConfig {
  static Future<void> init() async {
    try {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: 'AIzaSyCl6oiOPbEm2tpuVys9I0XtcttzhJY0354',
          authDomain: 'jinbeanpod.firebaseapp.com',
          projectId: 'jinbeanpod',
          storageBucket: 'jinbeanpod.firebasestorage.app',
          messagingSenderId: '628639117533',
          appId: '1:628639117533:android:25421734c44ff07bd72b34',
        ),
      );
    } catch (e) {
      debugPrint('Firebase initialization error: $e');
    }
  }
} 