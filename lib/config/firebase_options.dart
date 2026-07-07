import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.web:
        return webOptions;
      default:
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

  static const FirebaseOptions webOptions = FirebaseOptions(
    apiKey: 'AIzaSyCrcPI8ReNNKhsi6Kcn5Qeux4sgl5adp7E',
    appId: '1:90367474956:web:b0ca9cf07db62429729d29',
    messagingSenderId: '90367474956',
    projectId: 'homigo-care-8360e',
    authDomain: 'homigo-care-8360e.firebaseapp.com',
    databaseURL: 'https://homigo-care-8360e-default-rtdb.firebaseio.com',
    storageBucket: 'homigo-care-8360e.firebasestorage.app',
    measurementId: 'G-F78BY2281Y',
  );
}
