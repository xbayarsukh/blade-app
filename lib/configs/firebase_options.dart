import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDz69KNw-zycc-6xQ2xbMo8qLV8_Ng2-yI',
    appId: '1:440874907111:android:6c0a3d6cf65ad74f01b942',
    messagingSenderId: '440874907111',
    projectId: 'blade-260d6',
    storageBucket: 'blade-260d6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDTLxk1MtFB61R-kr_ns2cYLPbUf4LWZRs',
    appId: '1:440874907111:ios:ee66cace52fb949401b942',
    messagingSenderId: '440874907111',
    projectId: 'blade-260d6',
    storageBucket: 'blade-260d6.appspot.com',
    iosBundleId: 'mn.sukhee.blade',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDTLxk1MtFB61R-kr_ns2cYLPbUf4LWZRs',
    appId: '1:440874907111:ios:ee66cace52fb949401b942',
    messagingSenderId: '440874907111',
    projectId: 'blade-260d6',
    storageBucket: 'blade-260d6.appspot.com',
    iosBundleId: 'mn.sukhee.blade',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDTLxk1MtFB61R-kr_ns2cYLPbUf4LWZRs',
    appId: '1:440874907111:ios:ee66cace52fb949401b942',
    messagingSenderId: '440874907111',
    projectId: 'blade-260d6',
    storageBucket: 'blade-260d6.appspot.com',
    iosBundleId: 'mn.sukhee.blade',
    authDomain: 'blade-260d6.firebaseapp.com',
  );
}
