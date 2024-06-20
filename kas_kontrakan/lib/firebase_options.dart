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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyBh0inunTyVaHSgkGUlG0C0UGOVV4FH7VE',
    appId: '1:1031060654234:web:e967ff9264480020b3b723',
    messagingSenderId: '1031060654234',
    projectId: 'tubeskaskontrakan-3bda1',
    authDomain: 'tubeskaskontrakan-3bda1.firebaseapp.com',
    storageBucket: 'tubeskaskontrakan-3bda1.appspot.com',
    measurementId: 'G-X4NELJ5L04',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCacOCPsfAGKPg4KBfJ0pydYaY-HNajgok',
    appId: '1:1031060654234:android:d4cac8c2dd374727b3b723',
    messagingSenderId: '1031060654234',
    projectId: 'tubeskaskontrakan-3bda1',
    storageBucket: 'tubeskaskontrakan-3bda1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAqGIQt8VbITFSpcUo7slUof3RAluMXGDI',
    appId: '1:1031060654234:ios:b7c46001e859026eb3b723',
    messagingSenderId: '1031060654234',
    projectId: 'tubeskaskontrakan-3bda1',
    storageBucket: 'tubeskaskontrakan-3bda1.appspot.com',
    iosBundleId: 'com.example.kasKontrakan',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAqGIQt8VbITFSpcUo7slUof3RAluMXGDI',
    appId: '1:1031060654234:ios:b7c46001e859026eb3b723',
    messagingSenderId: '1031060654234',
    projectId: 'tubeskaskontrakan-3bda1',
    storageBucket: 'tubeskaskontrakan-3bda1.appspot.com',
    iosBundleId: 'com.example.kasKontrakan',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBh0inunTyVaHSgkGUlG0C0UGOVV4FH7VE',
    appId: '1:1031060654234:web:5f6cc0a672647538b3b723',
    messagingSenderId: '1031060654234',
    projectId: 'tubeskaskontrakan-3bda1',
    authDomain: 'tubeskaskontrakan-3bda1.firebaseapp.com',
    storageBucket: 'tubeskaskontrakan-3bda1.appspot.com',
    measurementId: 'G-B0J6X0BJRM',
  );
}