# FIREBASE SETUP GUIDE — Homigo Care

## Step-by-Step Firebase Configuration

---

## Step 1: Create Firebase Project

1. Go to https://console.firebase.google.com
2. Click **"Create a project"** or **"Add project"**
3. Enter project name: `homigo-care` (or your preferred name)
4. Enable/disable Google Analytics (optional)
5. Click **"Create project"**
6. Wait for project creation to complete
7. Click **"Continue"**

---

## Step 2: Register Android App

1. In Firebase Console, click the **Android icon** (or go to Project Settings > Add app)
2. Enter Android package name: `com.homigocare.app`
3. Enter app nickname: `Homigo Care`
4. Enter SHA-1 key (optional, for later)
5. Click **"Register app"**

---

## Step 3: Download google-services.json

1. After registering, click **"Download google-services.json"**
2. Save the file to your computer
3. Place it in your Flutter project:

```
Medical_Healthcare_App/
└── android/
    └── app/
        └── google-services.json    <-- HERE
```

4. Click **"Next"** in Firebase Console

---

## Step 4: Configure build.gradle Files

### android/build.gradle (Project-level)
```gradle
buildscript {
    dependencies {
        // Add this line
        classpath 'com.google.gms:google-services:4.4.0'
    }
}
```

### android/app/build.gradle (App-level)
```gradle
// Add at the top
apply plugin: 'com.google.gms.google-services'

// In android { } block
defaultConfig {
    // ... other config
    minSdkVersion 21
    targetSdkVersion 34
    multiDexEnabled true
}

dependencies {
    // Add these
    implementation 'com.google.firebase:firebase-auth:22.3.0'
    implementation 'com.google.firebase:firebase-database:20.3.0'
}
```

### android/settings.gradle
```gradle
// Ensure google-services classpath is available
pluginManagement {
    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}
```

---

## Step 5: Enable Email/Password Authentication

1. In Firebase Console, go to **"Authentication"**
2. Click **"Get started"**
3. Go to **"Sign-in method"** tab
4. Click on **"Email/Password"**
5. **Enable** the first option (Email/Password)
6. Click **"Save"**

### Email/Password Settings
- ✅ Email/Password: **Enabled**
- ✅ Email link sign-in: **Disabled** (for now)

---

## Step 6: Create Realtime Database

1. In Firebase Console, go to **"Realtime Database"**
2. Click **"Create database"**
3. Choose location: **United States** (or closest to your users)
4. Select security rules:
   - Start in **"test mode"** (we'll add proper rules later)
5. Click **"Enable"**

### Initial Database URL
Your database URL will be:
```
https://YOUR_PROJECT_ID-default-rtdb.firebaseio.com/
```

---

## Step 7: Deploy Security Rules

1. Go to **"Realtime Database"** > **"Rules"** tab
2. Copy the contents of `firebase_security_rules.txt`
3. Paste into the Rules editor
4. Click **"Publish"**

### Test Rules
```json
{
  "rules": {
    ".read": true,
    ".write": true
  }
}
```

### Production Rules
Copy from: `firebase_security_rules.txt`

---

## Step 8: Generate SHA-1 and SHA-256

### For Android (Required for Phone Auth)

Open terminal in Android Studio or project root:

```bash
# Navigate to android folder
cd android

# Generate debug key
./gradlew signingReport

# OR use keytool
keytool -list -v -alias androiddebugkey -keystore ~/.android/debug.keystore -storepass android
```

### Copy SHA Keys
```
SHA1: XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX
SHA256: XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX
```

### Add to Firebase
1. Go to **Project Settings** > **Your Apps** > Android app
2. Click **"Add fingerprint"**
3. Paste SHA-1 and SHA-256
4. Click **"Save"**

---

## Step 9: Configure Flutter Firebase SDK

### Option A: Firebase CLI (Recommended)

1. Install Firebase CLI:
```bash
npm install -g firebase-tools
```

2. Login to Firebase:
```bash
firebase login
```

3. Install FlutterFire CLI:
```bash
dart pub global activate flutterfire_cli
```

4. Configure Firebase in Flutter:
```bash
cd Medical_Healthcare_App
flutterfire configure
```

5. Select your Firebase project
6. Select Android (and iOS if needed)
7. This generates `lib/config/firebase_options.dart`

### Option B: Manual Configuration

1. Add to `pubspec.yaml`:
```yaml
dependencies:
  firebase_core: ^2.25.4
  firebase_auth: ^4.17.4
  firebase_database: ^10.4.4
```

2. Run `flutter pub get`

3. Initialize Firebase in `main.dart`:
```dart
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
```

---

## Step 10: Configure Android Manifest

### android/app/src/main/AndroidManifest.xml

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <!-- Add permissions -->
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.CAMERA" />
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.READ_MEDIA_IMAGES" />
    <uses-permission android:name="android.permission.POST_NOTIFICATIONS" />

    <application
        android:label="Homigo Care"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher"
        android:usesCleartextTraffic="true">
        
        <!-- Firebase will be auto-configured by google-services plugin -->
    </application>
</manifest>
```

---

## Step 11: Test Firebase Connection

### Create Test File

```dart
// lib/test_firebase.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

Future<void> testFirebase() async {
  // Test Auth
  final auth = FirebaseAuth.instance;
  print('Firebase Auth initialized: ${auth != null}');

  // Test Database
  final db = FirebaseDatabase.instance;
  print('Firebase Database initialized: ${db != null}');

  // Test Connection
  final connected = await db.ref().keepSynced(true);
  print('Database connected: $connected');
}
```

---

## Step 12: Firebase Project Settings

### General Settings
1. Go to **Project Settings**
2. Set project name: `Homigo Care`
3. Set project ID: `homigo-care` (or your choice)
4. Add support email

### Service Accounts
1. Go to **Service accounts**
2. Click **"Generate new private key"**
3. Save securely (for backend use only)

---

## Step 13: Enable Cloud Messaging (Optional)

1. Go to **Cloud Messaging** in Firebase Console
2. Note the **Server Key** (for backend notifications)
3. This is optional for initial release

---

## Step 14: Database Structure Setup

### Initial Data Structure

```json
{
  "users": {},
  "doctors": {},
  "appointments": {},
  "notifications": {},
  "settings": {
    "appName": "Homigo Care",
    "primaryColor": "#1AA69D",
    "secondaryColor": "#F2884B",
    "supportEmail": "support@homigocare.com",
    "supportPhone": "+92-300-1234567",
    "maintenanceMode": false
  },
  "splash": {
    "type": 1,
    "isEnabled": true
  },
  "banners": {}
}
```

---

## Firebase Console URLs

| Service | URL |
|---------|-----|
| Console | https://console.firebase.google.com |
| Authentication | https://console.firebase.google.com/authentication |
| Realtime Database | https://console.firebase.google.com/database |
| Project Settings | https://console.firebase.google.com/project/YOUR_PROJECT/settings |
| App Distribution | https://console.firebase.google.com/project/YOUR_PROJECT/appdistribution |

---

## Troubleshooting

### Common Issues

1. **"No Firebase App '[DEFAULT]' has been created"**
   - Ensure `Firebase.initializeApp()` is called before `runApp()`
   - Check `google-services.json` is in correct location

2. **"google-services.json is missing"**
   - Download from Firebase Console
   - Place in `android/app/`

3. **"SHA-1 not found"**
   - Generate using `keytool` or `./gradlew signingReport`
   - Add to Firebase Console > Project Settings > Android app

4. **Database permission denied**
   - Check security rules
   - Ensure user is authenticated
   - Verify data structure matches rules

5. **Auth popup blocked**
   - Enable Email/Password in Firebase Console
   - Check for ad blockers

---

## Environment Variables

### .env File (Create in project root)
```
FIREBASE_PROJECT_ID=your-project-id
FIREBASE_API_KEY=your-api-key
FIREBASE_AUTH_DOMAIN=your-project.firebaseapp.com
FIREBASE_DATABASE_URL=https://your-project-default-rtdb.firebaseio.com
FIREBASE_STORAGE_BUCKET=your-project.appspot.com
FIREBASE_MESSAGING_SENDER_ID=your-sender-id
FIREBASE_APP_ID=your-app-id
```

---

## Next Steps

After Firebase setup:
1. ✅ Test authentication flow
2. ✅ Test database read/write
3. ✅ Deploy security rules
4. ✅ Set up Cloudinary (see CLOUDINARY_SETUP.md)
5. ✅ Start building Flutter app
