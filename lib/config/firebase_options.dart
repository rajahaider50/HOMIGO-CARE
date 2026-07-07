import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    try {
      switch (defaultTargetPlatform) {
        case TargetPlatform.android:
          return android;
        case TargetPlatform.iOS:
          return ios;
        default:
          return android;
      }
    } catch (e) {
      return android;
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBmTL1zlv1M4FsnRkDZQqe9LzTqQlulEQY',
    appId: '1:90367474956:android:335d986b89445a95729d29',
    messagingSenderId: '90367474956',
    projectId: 'homigo-care-8360e',
    databaseURL: 'https://homigo-care-8360e-default-rtdb.firebaseio.com',
    storageBucket: 'homigo-care-8360e.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDU_-7QaAY0wANx6OjvrBjSYp9FOzVMNLU',
    appId: '1:90367474956:ios:4be9364089e81c8d729d29',
    messagingSenderId: '90367474956',
    projectId: 'homigo-care-8360e',
    databaseURL: 'https://homigo-care-8360e-default-rtdb.firebaseio.com',
    storageBucket: 'homigo-care-8360e.firebasestorage.app',
    iosBundleId: 'com.homigo.care',
  );
}
