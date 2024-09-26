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
    apiKey: 'AIzaSyDJ0z0Ge87FKELfXh7pnTwRlOMzfg4dJKE',
    appId: '1:227007992756:web:14f5837abac70b4568d8e1',
    messagingSenderId: '227007992756',
    projectId: 'gigantes-softbol',
    authDomain: 'gigantes-softbol.firebaseapp.com',
    storageBucket: 'gigantes-softbol.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCqqCTh0141LS7CTnJaCxCCAJ60e6lFxyQ',
    appId: '1:227007992756:android:4ccb4fd064ddad2e68d8e1',
    messagingSenderId: '227007992756',
    projectId: 'gigantes-softbol',
    storageBucket: 'gigantes-softbol.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCp6Z_liM4ZK0g8oaIUt8GeeM9maEKR8jI',
    appId: '1:227007992756:ios:cafe39d2eb0a999868d8e1',
    messagingSenderId: '227007992756',
    projectId: 'gigantes-softbol',
    storageBucket: 'gigantes-softbol.appspot.com',
    iosBundleId: 'com.example.softbol',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCp6Z_liM4ZK0g8oaIUt8GeeM9maEKR8jI',
    appId: '1:227007992756:ios:cafe39d2eb0a999868d8e1',
    messagingSenderId: '227007992756',
    projectId: 'gigantes-softbol',
    storageBucket: 'gigantes-softbol.appspot.com',
    iosBundleId: 'com.example.softbol',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDJ0z0Ge87FKELfXh7pnTwRlOMzfg4dJKE',
    appId: '1:227007992756:web:f0da8f6619eb1f1168d8e1',
    messagingSenderId: '227007992756',
    projectId: 'gigantes-softbol',
    authDomain: 'gigantes-softbol.firebaseapp.com',
    storageBucket: 'gigantes-softbol.appspot.com',
  );
}