# Homigo Care — Medical Healthcare App

> "Because Care Begins at Home"

A premium Flutter-based healthcare mobile application with Firebase backend and Cloudinary image storage.

---

## Features

- **Multi-Role Authentication** — Patient, Doctor, Nurse, Pharmacy, Vendor, Lab
- **Secure Registration** — 5-step registration with CNIC verification
- **Doctor Listing** — Search and filter doctors by specialization
- **Appointment Booking** — Book appointments with date/time selection
- **Admin Panel** — Complete application control
- **Real-time Database** — Firebase Realtime Database sync
- **Cloud Storage** — Cloudinary for all images and documents
- **Splash Screen System** — 4 types, admin-controlled
- **Premium UI/UX** — Material 3, glassmorphism, smooth animations

---

## Tech Stack

| Component | Technology |
|-----------|------------|
| Frontend | Flutter (Dart) |
| UI | Material 3 |
| State Management | Provider / Riverpod |
| Authentication | Firebase Authentication |
| Database | Firebase Realtime Database |
| Image Storage | Cloudinary |
| Fonts | Google Fonts (Poppins, Nunito Sans) |

---

## Quick Start

### Prerequisites
- Flutter SDK ≥ 3.19.0
- Dart SDK ≥ 3.3.0
- Android Studio / VS Code
- Firebase account
- Cloudinary account

### Installation

```bash
# Clone repository
cd "/storage/emulated/0/1 AI Websites/logo"
git clone <repository_url> Medical_Healthcare_App

# Navigate to project
cd Medical_Healthcare_App

# Install dependencies
flutter pub get

# Configure Firebase (see FIREBASE_SETUP.md)
# Configure Cloudinary (see CLOUDINARY_SETUP.md)

# Run app
flutter run
```

---

## Documentation

| Document | Description |
|----------|-------------|
| [PROJECT_REQUIREMENTS.md](PROJECT_REQUIREMENTS.md) | Complete project requirements |
| [PROJECT_BLUEPRINT.md](PROJECT_BLUEPRINT.md) | Development blueprint |
| [FIREBASE_SETUP.md](FIREBASE_SETUP.md) | Firebase configuration guide |
| [CLOUDINARY_SETUP.md](CLOUDINARY_SETUP.md) | Cloudinary configuration guide |
| [firebase_security_rules.txt](firebase_security_rules.txt) | Database security rules |
| [INSTALLATION.md](INSTALLATION.md) | Installation instructions |
| [TODO.md](TODO.md) | Development tasks |
| [CHANGELOG.md](CHANGELOG.md) | Version history |

---

## Color Palette

| Name | Hex | Usage |
|------|-----|-------|
| Primary Teal | #1AA69D | Main brand color |
| Dark Teal | #0F6E66 | Headings, dark buttons |
| Accent Orange | #F2884B | Highlights, heart logo |
| FAB Red | #E8543E | Floating action button |
| Text Dark | #1F2A2E | Headings, titles |
| Text Grey | #9AA5A9 | Placeholders |

---

## Folder Structure

```
Medical_Healthcare_App/
├── android/                    # Android native code
├── lib/                        # Dart source code
│   ├── config/                 # App configuration
│   ├── models/                 # Data models
│   ├── services/               # Business logic
│   ├── providers/              # State management
│   ├── screens/                # UI screens
│   ├── widgets/                # Reusable widgets
│   └── utils/                  # Utilities
├── assets/                     # Static assets
│   ├── logo/                   # App logos
│   ├── icons/                  # SVG icons
│   ├── images/                 # Static images
│   └── animations/             # Lottie/Rive files
├── test/                       # Tests
└── documentation files         # Project docs
```

---

## Development Status

| Phase | Status |
|-------|--------|
| Documentation | ✅ Complete |
| Firebase Setup | ⏳ Pending |
| Cloudinary Setup | ⏳ Pending |
| Project Structure | ⏳ Pending |
| Authentication | ⏳ Pending |
| Home Dashboard | ⏳ Pending |
| Doctor Screens | ⏳ Pending |
| Appointment Booking | ⏳ Pending |
| Admin Panel | ⏳ Pending |
| Testing | ⏳ Pending |
| Production | ⏳ Pending |

---

## License

Proprietary - All rights reserved.

---

## Support

For support and inquiries:
- Email: support@homigocare.com
- Documentation: See docs/ folder
