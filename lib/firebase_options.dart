// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyA2YTNeriWh4ruR9o4PjwTOEhtatlVyDcI',
    appId: '1:637543728152:web:45fa5790dace76e1812f6d',
    messagingSenderId: '637543728152',
    projectId: 'practice-8839c',
    authDomain: 'practice-8839c.firebaseapp.com',
    storageBucket: 'practice-8839c.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBOCs4Z-FDIcRClVg1ZPQYenYo_czDesJE',
    appId: '1:637543728152:android:b1510d1b27dff15c812f6d',
    messagingSenderId: '637543728152',
    projectId: 'practice-8839c',
    storageBucket: 'practice-8839c.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBVfPG_4_PN4XbVDv6iYTemY8-F9y68t2g',
    appId: '1:637543728152:ios:a2b00c2508724d11812f6d',
    messagingSenderId: '637543728152',
    projectId: 'practice-8839c',
    storageBucket: 'practice-8839c.firebasestorage.app',
    iosBundleId: 'com.example.dbapp',
  );
}
