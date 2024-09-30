// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyDcNV0YPEWukoVY_jDyuLTaWig2LhrNnV8',
    appId: '1:58042224281:web:d066af5ad53bacd178b208',
    messagingSenderId: '58042224281',
    projectId: 'web-url-52b6d',
    authDomain: 'web-url-52b6d.firebaseapp.com',
    storageBucket: 'web-url-52b6d.appspot.com',
    measurementId: 'G-GKQXTEYD5J',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC175Nj2Emqp7WSDLAKojOgrYSrr3pvXn4',
    appId: '1:58042224281:android:4f971f05b4ee15fa78b208',
    messagingSenderId: '58042224281',
    projectId: 'web-url-52b6d',
    storageBucket: 'web-url-52b6d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB20wq0B4O_3ftCdHPYUKZpBPeSsaX3BBo',
    appId: '1:58042224281:ios:21bec6df9f05120178b208',
    messagingSenderId: '58042224281',
    projectId: 'web-url-52b6d',
    storageBucket: 'web-url-52b6d.appspot.com',
    iosClientId: '58042224281-vcop1tfpb0eg0lsgesls9auspb3oochr.apps.googleusercontent.com',
    iosBundleId: 'com.app.bubblegpt',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB20wq0B4O_3ftCdHPYUKZpBPeSsaX3BBo',
    appId: '1:58042224281:ios:21bec6df9f05120178b208',
    messagingSenderId: '58042224281',
    projectId: 'web-url-52b6d',
    storageBucket: 'web-url-52b6d.appspot.com',
    iosClientId: '58042224281-vcop1tfpb0eg0lsgesls9auspb3oochr.apps.googleusercontent.com',
    iosBundleId: 'com.app.bubblegpt',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDcNV0YPEWukoVY_jDyuLTaWig2LhrNnV8',
    appId: '1:58042224281:web:3bdf4a5760a6f34178b208',
    messagingSenderId: '58042224281',
    projectId: 'web-url-52b6d',
    authDomain: 'web-url-52b6d.firebaseapp.com',
    storageBucket: 'web-url-52b6d.appspot.com',
    measurementId: 'G-C8E622BJ99',
  );

}