# PROJECT REQUIREMENTS — Homigo Care Medical Healthcare App

## 1. Development Environment

### Flutter SDK
- **Flutter SDK Version:** ≥ 3.19.0 (latest stable recommended)
- **Dart SDK Version:** ≥ 3.3.0
- **Android Studio:** Latest stable (for Android builds)
- **VS Code:** Latest with Flutter/Dart extensions
- **Xcode:** 15+ (for iOS builds, macOS required)

### Android Requirements
- **Minimum Android SDK:** 21 (Android 5.0 Lollipop)
- **Target Android SDK:** 34 (Android 14)
- **Compile SDK:** 34
- **Gradle Version:** 8.4+
- **Android Gradle Plugin:** 8.2.0+
- **NDK Version:** 25.2.9519653 (default)

### iOS Requirements (Future)
- **Minimum iOS Version:** 13.0
- **Xcode:** 15.0+
- **CocoaPods:** 1.15.0+

---

## 2. Required Packages (pubspec.yaml)

```yaml
dependencies:
  flutter:
    sdk: flutter

  # State Management
  provider: ^6.1.1
  # OR
  riverpod: ^2.4.9
  flutter_riverpod: ^2.4.9

  # Firebase Core
  firebase_core: ^2.25.4

  # Firebase Authentication
  firebase_auth: ^4.17.4

  # Firebase Realtime Database
  firebase_database: ^10.4.4

  # Cloudinary Integration
  cloudinary: ^1.2.0
  cloudinary_flutter: ^1.0.0
  # OR
  cloudinary_public: ^0.13.0+4

  # Image Picker (for camera/gallery)
  image_picker: ^1.0.7

  # Cached Network Image
  cached_network_image: ^3.3.1

  # Google Fonts
  google_fonts: ^6.1.0

  # Flutter SVG
  flutter_svg: ^2.0.9

  # Shared Preferences (local storage)
  shared_preferences: ^2.2.2

  # Path Provider
  path_provider: ^2.1.2

  # Permissions Handler
  permission_handler: ^11.3.0

  # HTTP Package
  http: ^1.2.1

  # File Picker
  file_picker: ^6.1.1

  # Video Player (for splash video)
  video_player: ^2.8.3

  # Webview (for HTML splash)
  webview_flutter: ^4.7.0

  # URL Launcher
  url_launcher: ^6.2.3

  # Intl (date formatting)
  intl: ^0.19.0

  # Lottie (animations)
  lottie: ^3.0.0

  # Connectivity Plus
  connectivity_plus: ^5.0.2

  # Flutter ScreenUtil (responsive)
  flutter_screenutil: ^5.9.1

  # Smooth Page Indicator
  smooth_page_indicator: ^1.1.0

  # Pin Code Field
  pin_code_fields: ^8.0.1

  # Loading Animation
  loading_animation_widget: ^1.2.1

  # Shimmer (loading effects)
  shimmer: ^3.0.0

  # Pinput (OTP input)
  pinput: ^3.0.1

  # Open File
  open_file: ^3.3.2

  # PDF Viewer
  flutter_pdfview: ^1.3.1

  # App version update
  in_app_update: ^4.2.0

dev_dependencies:
  flutter_test:
    sdk: flutter

  flutter_lints: ^3.0.1
  # OR
  flutter_lints: ^4.0.0
```

---

## 3. Firebase Configuration

### Firebase Project Setup
1. Create Firebase project at https://console.firebase.google.com
2. Register Android app with package name: `com.homigocare.app`
3. Download `google-services.json`
4. Place in: `android/app/google-services.json`

### Firebase Services to Enable
- ✅ Firebase Authentication
  - Email/Password sign-in method
- ✅ Firebase Realtime Database
  - Create database instance
  - Deploy security rules
- ❌ Firebase Storage (NOT USED — use Cloudinary)
- ❌ Cloud Firestore (NOT USED)
- ❌ Firebase Hosting (NOT USED)

### google-services.json Required Fields
```json
{
  "project_info": {
    "project_number": "YOUR_PROJECT_NUMBER",
    "project_id": "YOUR_PROJECT_ID",
    "storage_bucket": "YOUR_PROJECT_ID.appspot.com"
  },
  "client": [
    {
      "client_info": {
        "mobilesdk_app_id": "1:PROJECT_NUMBER:android:APP_ID",
        "android_client_info": {
          "package_name": "com.homigocare.app"
        }
      }
    }
  ]
}
```

---

## 4. Cloudinary Configuration

### Cloudinary Account Setup
1. Create account at https://cloudinary.com
2. Note your:
   - Cloud Name
   - API Key
   - API Secret
   - Upload Preset (unsigned)

### Cloudinary Folder Structure
```
homigo-care/
├── profiles/           # User profile images
├── cnic/              # CNIC front/back images
├── doctors/           # Doctor profile images
├── banners/           # Banner/slider images
├── splash/            # Splash screen assets
├── notifications/     # Notification images
├── lab/               # Lab images
├── pharmacy/          # Pharmacy images
├── documents/         # PDF/medical documents
└── logos/             # App logos
```

### Upload Configuration
```dart
// Upload Preset Name: homigo_care_unsigned
// Folder: homigo-care/
// Allowed formats: jpg, jpeg, png, webp, gif, pdf, mp4
// Max file size: 10MB (images), 50MB (videos)
// Transformations: auto optimization, quality 80%
```

---

## 5. API Keys Required

| Key | Location | Purpose |
|-----|----------|---------|
| Firebase Web API Key | google-services.json | Authentication |
| Firebase Project ID | google-services.json | Database URL |
| Cloudinary Cloud Name | Environment/Config | Image uploads |
| Cloudinary API Key | Environment/Config | Image uploads |
| Cloudinary API Secret | Environment/Config | Signed uploads |
| Cloudinary Upload Preset | Environment/Config | Unsigned uploads |

### Secure Key Storage
- Store keys in `.env` file (not committed to git)
- Use `--dart-define` for build-time variables
- Never hardcode secrets in source code

---

## 6. Android Permissions

### Required Permissions (AndroidManifest.xml)
```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.READ_MEDIA_IMAGES" />
<uses-permission android:name="android.permission.READ_MEDIA_VIDEO" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED" />
<uses-permission android:name="android.permission.VIBRATE" />
<uses-permission android:name="android.permission.SCHEDULE_EXACT_ALARM" />
```

### Android 13+ Permissions
```xml
<uses-permission android:name="android.permission.POST_NOTIFICATIONS" />
<uses-permission android:name="android.permission.READ_MEDIA_IMAGES" />
```

---

## 7. Folder Structure

```
Medical_Healthcare_App/
├── android/                          # Android native code
│   └── app/
│       ├── google-services.json      # Firebase config
│       └── src/main/
│           └── AndroidManifest.xml   # Permissions
├── ios/                              # iOS native code (future)
├── lib/                              # Main Dart source
│   ├── main.dart                     # App entry point
│   ├── app.dart                      # MaterialApp config
│   ├── config/
│   │   ├── firebase_options.dart     # Firebase config
│   │   ├── cloudinary_config.dart    # Cloudinary config
│   │   ├── app_config.dart           # App constants
│   │   ├── theme.dart                # Theme data
│   │   └── routes.dart               # Named routes
│   ├── models/
│   │   ├── user_model.dart           # User data model
│   │   ├── doctor_model.dart         # Doctor data model
│   │   ├── appointment_model.dart    # Appointment model
│   │   ├── notification_model.dart   # Notification model
│   │   ├── splash_model.dart         # Splash config model
│   │   └── banner_model.dart         # Banner model
│   ├── services/
│   │   ├── auth_service.dart         # Firebase Auth
│   │   ├── database_service.dart     # Realtime Database
│   │   ├── cloudinary_service.dart   # Cloudinary uploads
│   │   ├── notification_service.dart # Push notifications
│   │   └── splash_service.dart       # Splash config
│   ├── providers/
│   │   ├── auth_provider.dart        # Auth state
│   │   ├── user_provider.dart        # User data
│   │   ├── doctor_provider.dart      # Doctors list
│   │   ├── appointment_provider.dart # Appointments
│   │   └── theme_provider.dart       # Theme state
│   ├── screens/
│   │   ├── splash/
│   │   │   ├── splash_screen.dart
│   │   │   ├── splash_type1.dart
│   │   │   ├── splash_type2.dart
│   │   │   ├── splash_type3.dart
│   │   │   └── splash_type4.dart
│   │   ├── auth/
│   │   │   ├── login_screen.dart
│   │   │   ├── register_screen.dart
│   │   │   ├── role_selection_screen.dart
│   │   │   ├── forgot_password_screen.dart
│   │   │   └── otp_verification_screen.dart
│   │   ├── registration/
│   │   │   ├── step1_role_selection.dart
│   │   │   ├── step2_personal_details.dart
│   │   │   ├── step3_verification.dart
│   │   │   ├── step4_medical_info.dart
│   │   │   └── step5_account_creation.dart
│   │   ├── home/
│   │   │   ├── home_screen.dart
│   │   │   └── home_dashboard.dart
│   │   ├── doctors/
│   │   │   ├── doctors_list_screen.dart
│   │   │   ├── doctor_detail_screen.dart
│   │   │   └── search_doctors_screen.dart
│   │   ├── appointments/
│   │   │   ├── booking_screen.dart
│   │   │   ├── appointments_screen.dart
│   │   │   └── appointment_detail_screen.dart
│   │   ├── profile/
│   │   │   ├── profile_screen.dart
│   │   │   └── edit_profile_screen.dart
│   │   ├── notifications/
│   │   │   └── notifications_screen.dart
│   │   ├── settings/
│   │   │   ├── settings_screen.dart
│   │   │   ├── about_screen.dart
│   │   │   └── privacy_policy_screen.dart
│   │   └── admin/
│   │       ├── admin_dashboard_screen.dart
│   │       ├── user_management_screen.dart
│   │       ├── doctor_management_screen.dart
│   │       ├── appointment_management_screen.dart
│   │       ├── document_verification_screen.dart
│   │       ├── splash_management_screen.dart
│   │       ├── notification_management_screen.dart
│   │       └── app_settings_screen.dart
│   ├── widgets/
│   │   ├── common/
│   │   │   ├── custom_button.dart
│   │   │   ├── custom_text_field.dart
│   │   │   ├── custom_card.dart
│   │   │   ├── loading_widget.dart
│   │   │   ├── error_widget.dart
│   │   │   ├── empty_state_widget.dart
│   │   │   └── glassmorphism_card.dart
│   │   ├── home/
│   │   │   ├── service_grid.dart
│   │   │   ├── featured_doctors.dart
│   │   │   ├── search_bar.dart
│   │   │   ├── slider_banner.dart
│   │   │   └── emergency_button.dart
│   │   ├── doctor/
│   │   │   ├── doctor_card.dart
│   │   │   └── doctor_specialty_chip.dart
│   │   └── navigation/
│   │       ├── custom_drawer.dart
│   │       └── custom_bottom_nav.dart
│   ├── utils/
│   │   ├── constants.dart            # App constants
│   │   ├── validators.dart           # Form validators
│   │   ├── formatters.dart           # Input formatters
│   │   ├── helpers.dart              # Utility functions
│   │   └── extensions.dart           # Dart extensions
│   └── assets/
│       ├── icons/                    # SVG icons
│       ├── images/                   # Static images
│       └── animations/              # Lottie/Rive files
├── assets/
│   ├── logo/
│   │   ├── logo.png                  # Official logo
│   │   ├── simple.jpg                # Placeholder
│   │   └── logo.php                  # Logo data
│   ├── icons/
│   │   ├── patient.svg
│   │   ├── nurse.svg
│   │   ├── doctor.svg
│   │   ├── lab.svg
│   │   ├── pharmacy.svg
│   │   └── vendor.svg
│   ├── images/
│   │   ├── splash_bg.png
│   │   ├── login_bg.png
│   │   ├── empty_state.png
│   │   └── placeholder.jpg
│   ├── animations/
│   │   ├── loading.json
│   │   ├── splash.json
│   │   └── empty.json
│   └── fonts/
│       └── (Google Fonts loaded via package)
├── test/                            # Unit & Widget tests
├── .env                             # Environment variables
├── .gitignore
├── pubspec.yaml
├── README.md
└── firebase_security_rules.json     # Security rules
```

---

## 8. Project Architecture

### Architecture Pattern: **Clean Architecture + Provider**

```
┌─────────────────────────────────────────┐
│              PRESENTATION                │
│  Screens → Widgets → Providers          │
├─────────────────────────────────────────┤
│              BUSINESS LOGIC             │
│  Services → Models → Utils              │
├─────────────────────────────────────────┤
│              DATA LAYER                 │
│  Firebase Auth + Realtime DB + Cloudinary│
└─────────────────────────────────────────┘
```

### State Management: **Provider**
- AuthProvider: Authentication state
- UserProvider: User data management
- DoctorProvider: Doctor listings
- AppointmentProvider: Bookings
- ThemeProvider: App theming
- SplashProvider: Splash configuration

---

## 9. Required Assets

### Logo Assets
| File | Size | Usage |
|------|------|-------|
| logo.png | 1000x1200px | Main app logo |
| simple.jpg | Variable | Placeholder image |
| logo.php | Variable | Logo data file |

### Generated App Icons
| Size | Usage |
|------|-------|
| 48x48 | Notification icon |
| 72x72 | App launcher (mdpi) |
| 96x96 | App launcher (hdpi) |
| 144x144 | App launcher (xhdpi) |
| 192x192 | App launcher (xxhdpi) |
| 512x512 | App launcher (Play Store) |

### Role Icons (SVG)
| Icon | Color |
|------|-------|
| Patient | Grey #B7C0C3 (inactive) / Teal #1AA69D (active) |
| Nurse | Grey #B7C0C3 (inactive) / Teal #1AA69D (active) |
| Doctor | Grey #B7C0C3 (inactive) / Teal #1AA69D (active) |
| Lab | Grey #B7C0C3 (inactive) / Teal #1AA69D (active) |
| Pharmacy | Grey #B7C0C3 (inactive) / Teal #1AA69D (active) |
| Vendor | Grey #B7C0C3 (inactive) / Teal #1AA69D (active) |

### Placeholder Images
| Image | Purpose |
|-------|---------|
| doctor_placeholder.jpg | Doctor cards |
| profile_placeholder.jpg | User profiles |
| banner_placeholder.jpg | Slider banners |
| empty_state.png | Empty lists |
| loading_bg.png | Loading screens |

---

## 10. Color Palette

| Name | Hex | RGB | Usage |
|------|-----|-----|-------|
| Primary Teal (Dark) | #0F6E66 | 15, 110, 102 | Logo, headings, dark buttons |
| Primary Teal (Light) | #1AA69D | 26, 166, 157 | Main brand, app bar, active states |
| Accent Orange | #F2884B | 242, 136, 75 | Heart logo, highlights |
| Accent Orange (Light) | #F5A96B | 245, 169, 107 | Heart gradient |
| FAB Red/Coral | #E8543E | 232, 84, 62 | FAB background |
| Text Dark | #1F2A2E | 31, 42, 46 | Headings, titles |
| Text Grey | #9AA5A9 | 154, 165, 169 | Placeholders, inactive |
| Card Border Grey | #E0E4E6 | 224, 228, 230 | Card borders |
| Card Background | #FFFFFF | 255, 255, 255 | Card fills |
| Card Selected | #1AA69D | 26, 166, 157 | Selected cards |
| Icon Grey (Inactive) | #B7C0C3 | 183, 192, 195 | Inactive icons |
| Icon Teal (Active) | #1AA69D | 26, 166, 157 | Active icons |
| Background | #FFFFFF | 255, 255, 255 | App background |
| Success | #2E7D32 | 46, 125, 50 | Success states |
| Warning | #F9A825 | 249, 168, 37 | Warning states |
| Error | #C62828 | 198, 40, 40 | Error states |

### Gradients
```
Logo House: linear-gradient(135deg, #0F6E66 0%, #1AA69D 100%)
Logo Heart: linear-gradient(135deg, #F2884B 0%, #F5A96B 100%)
Primary Button: linear-gradient(135deg, #1AA69D 0%, #0F6E66 100%)
```

---

## 11. Typography

| Element | Font | Size | Weight | Color |
|---------|------|------|--------|-------|
| App Logo "HOMIGO" | Poppins | 32sp | Bold (700) | #1AA69D |
| App Logo "CARE" | Poppins | 32sp | Bold (700) | #F2884B |
| Tagline | Nunito Sans | 13sp | Regular (400) | #1F2A2E |
| Screen Heading | Poppins | 24sp | SemiBold (600) | #1F2A2E |
| Card Label | Nunito Sans | 14sp | Medium (500) | #1F2A2E |
| Body Text | Nunito Sans | 14sp | Regular (400) | #1F2A2E |
| Search Placeholder | Nunito Sans | 14sp | Regular (400) | #9AA5A9 |
| Bottom Nav Label | Nunito Sans | 11sp | Medium (500) | active/inactive |
| Button Text | Poppins | 16sp | SemiBold (600) | #FFFFFF |
| Small Text | Nunito Sans | 12sp | Regular (400) | #9AA5A9 |

---

## 12. Icon Library

### Primary Icons
- **Material Icons** (flutter built-in)
- **Cupertino Icons** (flutter built-in)
- **Font Awesome Medical** (font_awesome_flutter package)
- **Custom SVG Icons** (flutter_svg package)

### Role Icons
- Patient: person/user icon
- Nurse: nurse cap with plus
- Doctor: stethoscope icon
- Lab: flask/conical flask
- Pharmacy: pill/medicine bottle
- Vendor: shop/storefront

### Navigation Icons
- Home: house outline
- Bookings: calendar outline
- Chat: chat-bubble outline
- Profile: person outline
- Notifications: bell outline
- Search: magnifying glass
- Menu: hamburger menu
- Back: chevron-left
- Forward: chevron-right

---

## 13. Database Structure

### Realtime Database Schema
```json
{
  "users": {
    "uid": {
      "email": "string",
      "phoneNumber": "string",
      "role": "patient|doctor|nurse|pharmacy",
      "firstName": "string",
      "lastName": "string",
      "fullName": "string",
      "age": "number",
      "weight": "number",
      "height": "number",
      "gender": "string",
      "profileImage": "cloudinary_url",
      "cnicFront": "cloudinary_url",
      "cnicBack": "cloudinary_url",
      "allergies": "string",
      "illness": "string",
      "isVerified": "boolean",
      "isActive": "boolean",
      "isAdmin": "boolean",
      "createdAt": "timestamp",
      "updatedAt": "timestamp"
    }
  },
  "doctors": {
    "uid": {
      "specialization": "string",
      "availability": "object",
      "rating": "number",
      "consultationFee": "number",
      "description": "string",
      "qualifications": "array",
      "experience": "number",
      "clinicAddress": "string",
      "isApproved": "boolean"
    }
  },
  "appointments": {
    "appointmentId": {
      "patientId": "uid",
      "doctorId": "uid",
      "date": "date",
      "time": "time",
      "status": "pending|confirmed|completed|cancelled",
      "type": "string",
      "notes": "string",
      "createdAt": "timestamp"
    }
  },
  "notifications": {
    "notificationId": {
      "title": "string",
      "body": "string",
      "type": "string",
      "targetRole": "string",
      "isRead": "boolean",
      "createdAt": "timestamp"
    }
  },
  "settings": {
    "appName": "string",
    "logo": "cloudinary_url",
    "primaryColor": "string",
    "secondaryColor": "string",
    "supportEmail": "string",
    "supportPhone": "string",
    "privacyPolicy": "string",
    "termsOfService": "string",
    "about": "string",
    "maintenanceMode": "boolean"
  },
  "splash": {
    "type": 1,
    "isEnabled": true,
    "videoUrl": "cloudinary_url",
    "imageUrl": "cloudinary_url",
    "htmlContent": "string",
    "animatedText": "string"
  },
  "banners": {
    "bannerId": {
      "imageUrl": "cloudinary_url",
      "title": "string",
      "link": "string",
      "isActive": "boolean",
      "order": "number"
    }
  }
}
```

---

## 14. Authentication Flow

### Registration Flow
```
Role Selection (Step 1)
    ↓
Personal Details (Step 2)
    ↓
Document Verification (Step 3) → Cloudinary Upload
    ↓
Medical Information (Step 4)
    ↓
Account Creation (Step 5) → Firebase Auth
    ↓
Save to Realtime Database
    ↓
Email Verification
    ↓
Admin Approval (if doctor/nurse)
    ↓
Dashboard
```

### Login Flow
```
Email + Password Input
    ↓
Firebase Auth Sign-In
    ↓
Fetch User Data from Realtime DB
    ↓
Check Verification Status
    ↓
Role-Based Dashboard Redirect
```

---

## 15. Upload Flow

### Cloudinary Upload Process
```
Select Image/File
    ↓
Compress Image (if needed)
    ↓
Generate Unique Filename
    ↓
Upload to Cloudinary
    ↓
Receive URL Response
    ↓
Save URL to Firebase Realtime DB
    ↓
Display Image from URL
```

---

## 16. Admin Panel Architecture

### Admin Features
- Dashboard with analytics
- User management (CRUD)
- Doctor approval workflow
- Document verification
- Appointment management
- Splash screen control
- Notification management
- App settings
- Banner management

### Admin Access Control
- Only users with `isAdmin: true` can access
- Admin routes protected with middleware
- Real-time data sync
- Audit logging

---

## 17. User Panel Architecture

### Patient Features
- Home dashboard
- Search doctors
- Book appointments
- View medical history
- Manage profile
- Notifications
- Settings

### Doctor Features
- View appointments
- Manage schedule
- Patient records
- Profile management
- Availability toggle

### Nurse Features
- Assigned patients
- Schedule view
- Profile management

### Pharmacy Features
- View prescriptions
- Order management
- Profile management

---

## 18. Security Plan

### Authentication Security
- Firebase Auth with email/password
- Password hashing (Firebase handles)
- Session management
- Auto-logout on inactivity

### Data Security
- Role-based access control
- Input validation on all forms
- Sanitize user inputs
- Rate limiting on API calls
- HTTPS only

### File Upload Security
- File type validation
- File size limits
- Signed URLs for private files
- Cloudinary folder restrictions

### Database Security
- Firebase Realtime Database rules
- User can only read/write own data
- Admin-only write for settings
- Server-side validation

---

## 19. Testing Checklist

### Unit Tests
- [ ] Auth service functions
- [ ] Database service functions
- [ ] Cloudinary service functions
- [ ] Form validators
- [ ] Model serialization/deserialization
- [ ] Utility functions

### Widget Tests
- [ ] Login screen
- [ ] Registration screens
- [ ] Home screen
- [ ] Doctor list
- [ ] Appointment booking
- [ ] Profile screen
- [ ] Admin dashboard
- [ ] All common widgets

### Integration Tests
- [ ] Complete registration flow
- [ ] Login/logout flow
- [ ] Book appointment flow
- [ ] Upload profile image
- [ ] Admin approval flow
- [ ] Splash screen types

### Manual Testing
- [ ] All screens render correctly
- [ ] All navigation works
- [ ] Forms validate correctly
- [ ] Images upload to Cloudinary
- [ ] Data saves to Firebase
- [ ] Real-time updates work
- [ ] Roles have correct permissions
- [ ] Admin panel functions
- [ ] Splash screen types work
- [ ] Notifications display
- [ ] Offline handling
- [ ] Error states display
- [ ] Loading states display
- [ ] Responsive layout
- [ ] Dark/Light theme

---

## 20. Performance Requirements

- App launch time: < 3 seconds
- Screen transitions: < 300ms
- Image loading: < 2 seconds
- API response handling: < 1 second
- Smooth 60fps animations
- Memory usage: < 200MB
- Battery optimization
- Efficient image caching

---

## 21. Production Readiness

### Before Release
- [ ] All features implemented
- [ ] All tests passing
- [ ] Performance optimized
- [ ] Security audit complete
- [ ] Firebase rules deployed
- [ ] Cloudinary configured
- [ ] App signing configured
- [ ] Play Store listing ready
- [ ] Privacy policy published
- [ ] Terms of service published
- [ ] Support email configured
- [ ] Crash reporting enabled
- [ ] Analytics enabled
