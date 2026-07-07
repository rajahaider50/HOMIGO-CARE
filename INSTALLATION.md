# INSTALLATION GUIDE — Homigo Care

## Complete Setup Instructions

---

## Prerequisites

### Required Software

1. **Flutter SDK** (≥ 3.19.0)
   - Download: https://flutter.dev/docs/get-started/install
   - Add to PATH

2. **Dart SDK** (≥ 3.3.0)
   - Included with Flutter SDK

3. **Android Studio** (Latest stable)
   - Download: https://developer.android.com/studio
   - Install Android SDK (API 34)
   - Install Flutter/Dart plugins

4. **VS Code** (Optional but recommended)
   - Download: https://code.visualstudio.com
   - Install Flutter extension
   - Install Dart extension

5. **Git**
   - Download: https://git-scm.com

---

## Step 1: Clone/Download Project

```bash
# Navigate to project location
cd "/storage/emulated/0/1 AI Websites/logo"

# Clone repository (if using git)
git clone <repository_url> Medical_Healthcare_App

# OR download and extract ZIP
```

---

## Step 2: Install Flutter Dependencies

```bash
# Navigate to project
cd Medical_Healthcare_App

# Install dependencies
flutter pub get

# Verify Flutter installation
flutter doctor
```

---

## Step 3: Configure Firebase

1. Follow instructions in `FIREBASE_SETUP.md`
2. Download `google-services.json`
3. Place in `android/app/`
4. Configure `build.gradle` files

---

## Step 4: Configure Cloudinary

1. Follow instructions in `CLOUDINARY_SETUP.md`
2. Create account and get credentials
3. Create upload presets
4. Update `.env` file

---

## Step 5: Create Environment File

### Create `.env` file in project root:

```env
# Firebase Configuration
FIREBASE_PROJECT_ID=your-project-id
FIREBASE_API_KEY=your-api-key
FIREBASE_AUTH_DOMAIN=your-project.firebaseapp.com
FIREBASE_DATABASE_URL=https://your-project-default-rtdb.firebaseio.com
FIREBASE_STORAGE_BUCKET=your-project.appspot.com
FIREBASE_MESSAGING_SENDER_ID=your-sender-id
FIREBASE_APP_ID=your-app-id

# Cloudinary Configuration
CLOUDINARY_CLOUD_NAME=your-cloud-name
CLOUDINARY_API_KEY=your-api-key
CLOUDINARY_API_SECRET=your-api-secret
CLOUDINARY_UPLOAD_PRESET=homigo_care_unsigned
```

---

## Step 6: Configure Android

### Update android/app/build.gradle:

```gradle
android {
    compileSdkVersion 34
    
    defaultConfig {
        applicationId "com.homigocare.app"
        minSdkVersion 21
        targetSdkVersion 34
        versionCode 1
        versionName "1.0.0"
    }
    
    buildTypes {
        release {
            signingConfig signingConfigs.debug
            minifyEnabled true
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        }
    }
}

dependencies {
    implementation 'com.google.firebase:firebase-auth:22.3.0'
    implementation 'com.google.firebase:firebase-database:20.3.0'
}
```

---

## Step 7: Run the App

```bash
# Check connected devices
flutter devices

# Run on Android
flutter run

# Run on specific device
flutter run -d <device_id>

# Run in release mode
flutter run --release

# Build APK
flutter build apk

# Build App Bundle
flutter build appbundle
```

---

## Step 8: First Launch

1. App will show splash screen
2. Navigate to login/registration
3. Register as a new user
4. Test all features

---

## Development Commands

### Build Commands
```bash
# Debug build
flutter run --debug

# Release build
flutter run --release

# Profile build
flutter run --profile

# Clean build
flutter clean
flutter pub get
flutter run
```

### Code Quality
```bash
# Analyze code
flutter analyze

# Format code
dart format .

# Run tests
flutter test

# Run specific test
flutter test test/widget_test.dart
```

### Dependencies
```bash
# Add package
flutter pub add <package_name>

# Add dev dependency
flutter pub add --dev <package_name>

# Remove package
flutter pub remove <package_name>

# Update packages
flutter pub upgrade

# Outdated packages
flutter pub outdated
```

---

## Troubleshooting

### Common Issues

1. **"flutter: command not found"**
   - Add Flutter to PATH
   - Restart terminal
   - Run `flutter doctor`

2. **"No connected devices"**
   - Enable USB debugging on Android
   - Install device drivers
   - Run `flutter devices`

3. **"pub get failed"**
   - Check internet connection
   - Run `flutter clean` then `flutter pub get`
   - Check pubspec.yaml syntax

4. **"Build failed"**
   - Check Android SDK version
   - Update Gradle version
   - Check for missing dependencies

5. **"Firebase not initialized"**
   - Verify `google-services.json` location
   - Check `build.gradle` configuration
   - Run `flutter clean` and rebuild

### Performance Issues

1. **Slow builds**
   - Enable Gradle daemon
   - Increase heap size
   - Use `--release` flag

2. **App crashes**
   - Check logs with `flutter logs`
   - Test on different devices
   - Verify Firebase configuration

---

## Environment Variables

### Using --dart-define
```bash
# Run with environment variables
flutter run \
  --dart-define=CLOUDINARY_CLOUD_NAME=your_cloud_name \
  --dart-define=CLOUDINARY_API_KEY=your_api_key
```

### Using dotenv package
```dart
// In main.dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load();
  runApp(MyApp());
}
```

---

## Git Setup

### Create .gitignore
```
# Flutter/Dart
.dart_tool/
.packages
build/
*.iml
.idea/
.vscode/
*.lock

# Android
android/app/debug/
android/app/profile/
android/app/release/
android/local.properties
android/key.properties
*.jks
*.keystore

# iOS
ios/Pods/
ios/.symlinks/
ios/Flutter/Flutter.framework
ios/Flutter/Flutter.podspec

# Environment
.env
*.env.local
*.env.development.local
*.env.test.local
*.env.production.local

# Firebase
google-services.json
GoogleService-Info.plist

# Cloudinary
cloudinary_config.json

# Logs
*.log
logs/

# OS
.DS_Store
Thumbs.db

# Testing
coverage/
*.lcov

# Build
*.apk
*.aab
*.ipa
```

---

## IDE Setup

### VS Code Extensions
- Flutter
- Dart
- Firebase for VS Code
- Cloud Code
- Error Lens
- GitLens

### Android Studio Plugins
- Flutter
- Dart
- Firebase
- Kotlin

---

## Testing

### Unit Tests
```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# View coverage report
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

### Widget Tests
```bash
# Run specific test file
flutter test test/widget_test.dart

# Run tests in folder
flutter test test/
```

### Integration Tests
```bash
# Run integration tests
flutter test integration_test/
```

---

## Production Build

### Android Release
```bash
# Build APK
flutter build apk --release

# Build App Bundle (recommended for Play Store)
flutter build appbundle --release

# Build with obfuscation
flutter build apk --release --obfuscate --split-debug-info=build/debug-info
```

### iOS Release (requires macOS)
```bash
# Build iOS
flutter build ios --release

# Build IPA
flutter build ipa --release
```

---

## Next Steps

After installation:
1. ✅ Verify all features work
2. ✅ Test on real devices
3. ✅ Configure CI/CD (optional)
4. ✅ Set up crash reporting
5. ✅ Prepare for production release
