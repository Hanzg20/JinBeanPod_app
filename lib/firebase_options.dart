import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:flutter/foundation.dart' show debugPrint;

class FirebaseConfig {
  static FirebaseOptions get currentPlatform {
    debugPrint('Initializing Firebase with platform: ${defaultTargetPlatform.toString()}');
    
    if (kIsWeb) {
      debugPrint('Using web Firebase configuration');
      return web;
    }
    
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        debugPrint('Using Android Firebase configuration');
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for android - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.iOS:
        debugPrint('Using iOS Firebase configuration');
        return ios;
      case TargetPlatform.macOS:
        debugPrint('Using macOS Firebase configuration');
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAQoIOAWmvsljckCBRvrBAUaPHQVYnE20k',
    appId: '1:628639117533:web:d00dd27817c376f9d72b34',
    messagingSenderId: '628639117533',
    projectId: 'jinbeanpod',
    authDomain: 'jinbeanpod.firebaseapp.com',
    storageBucket: 'jinbeanpod.appspot.com',
    measurementId: 'G-MEASUREMENT_ID',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAQoIOAWmvsljckCBRvrBAUaPHQVYnE20k',
    appId: '1:628639117533:ios:d00dd27817c376f9d72b34',
    messagingSenderId: '628639117533',
    projectId: 'jinbeanpod',
    storageBucket: 'jinbeanpod.appspot.com',
    iosClientId: 'YOUR_IOS_CLIENT_ID',
    iosBundleId: 'com.jinbeanpod.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAQoIOAWmvsljckCBRvrBAUaPHQVYnE20k',
    appId: '1:628639117533:macos:d00dd27817c376f9d72b34',
    messagingSenderId: '628639117533',
    projectId: 'jinbeanpod',
    storageBucket: 'jinbeanpod.appspot.com',
    iosClientId: 'YOUR_IOS_CLIENT_ID',
    iosBundleId: 'com.jinbeanpod.app',
  );
} 