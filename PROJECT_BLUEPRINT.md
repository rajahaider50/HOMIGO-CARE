# PROJECT BLUEPRINT — Homigo Care Medical Healthcare App

## Complete Development Blueprint

---

## 1. Project Overview

**App Name:** Homigo Care
**Tagline:** "Because Care Begins at Home"
**Category:** Home Healthcare Services App
**Platform:** Flutter (Android + iOS)
**Architecture:** Clean Architecture + Provider

---

## 2. Technology Stack

### Frontend
- **Framework:** Flutter (Dart)
- **UI:** Material 3
- **State Management:** Provider / Riverpod
- **Fonts:** Google Fonts (Poppins, Nunito Sans)
- **Icons:** Material Icons + Custom SVG

### Backend
- **Authentication:** Firebase Authentication (Email/Password)
- **Database:** Firebase Realtime Database
- **Image Storage:** Cloudinary
- **Notifications:** Firebase Cloud Messaging (Optional)

---

## 3. Application Roles

| Role | Description | Dashboard |
|------|-------------|-----------|
| Patient | Books appointments, views doctors | Patient Dashboard |
| Doctor | Manages appointments, views patients | Doctor Dashboard |
| Nurse | Views assigned patients, schedule | Nurse Dashboard |
| Pharmacy | Views prescriptions, orders | Pharmacy Dashboard |
| Vendor | Manages medical supplies | Vendor Dashboard |
| Admin | Full system control | Admin Panel |

---

## 4. Color Palette

| Name | Hex | Usage |
|------|-----|-------|
| Primary Teal (Dark) | #0F6E66 | Logo, headings, dark buttons |
| Primary Teal (Light) | #1AA69D | Main brand, app bar, active states |
| Accent Orange | #F2884B | Heart logo, highlights |
| Accent Orange (Light) | #F5A96B | Heart gradient |
| FAB Red/Coral | #E8543E | FAB background |
| Text Dark | #1F2A2E | Headings, titles |
| Text Grey | #9AA5A9 | Placeholders, inactive |
| Card Border Grey | #E0E4E6 | Card borders |
| Icon Grey (Inactive) | #B7C0C3 | Inactive icons |
| Icon Teal (Active) | #1AA69D | Active icons |
| Success | #2E7D32 | Success states |
| Warning | #F9A825 | Warning states |
| Error | #C62828 | Error states |

---

## 5. Typography

| Element | Font | Size | Weight | Color |
|---------|------|------|--------|-------|
| Logo "HOMIGO" | Poppins | 32sp | Bold (700) | #1AA69D |
| Logo "CARE" | Poppins | 32sp | Bold (700) | #F2884B |
| Tagline | Nunito Sans | 13sp | Regular (400) | #1F2A2E |
| Screen Heading | Poppins | 24sp | SemiBold (600) | #1F2A2E |
| Card Label | Nunito Sans | 14sp | Medium (500) | #1F2A2E |
| Body Text | Nunito Sans | 14sp | Regular (400) | #1F2A2E |
| Button Text | Poppins | 16sp | SemiBold (600) | #FFFFFF |

---

## 6. Screen Flow

### Splash Screen System
```
App Launch
    ↓
Check Splash Type (from Firebase)
    ↓
├── Type 1: Default Animation
├── Type 2: Video Splash
├── Type 3: Image Splash
└── Type 4: HTML/Text Splash
    ↓
Auto-navigate to Role Selection
```

### Authentication Flow
```
Role Selection
    ↓
Registration (5 Steps)
├── Step 1: Role Selection
├── Step 2: Personal Details
├── Step 3: Document Verification
├── Step 4: Medical Information
└── Step 5: Account Creation
    ↓
Login
    ↓
Dashboard (Role-Based)
```

### Home Dashboard Flow
```
Home Screen
├── Logo & Branding
├── Search Bar
├── Service Grid
├── Featured Doctors
├── Slider/Banners
└── Emergency Button
    ↓
Bottom Navigation
├── Home
├── Bookings
├── Chat
└── Profile
```

---

## 7. Screen Breakdown

### 7.1 Splash Screen
- White background
- Centered logo (house + hands + heart)
- Wordmark "HOMIGO CARE"
- Tagline "Because Care Begins at Home"
- Auto-navigate after 2 seconds

### 7.2 Role Selection Screen
- White background
- Heading: "Select a role"
- 2x3 grid of role cards
- Selected card: Teal background, white text
- Unselected cards: White background, grey border
- Icons: Patient, Nurse, Doctor, Lab, Pharmacy, Vendor

### 7.3 Home Screen
- **Top:** Logo, wordmark, tagline (centered)
- **Search Bar:** Rounded, light border, grey placeholder
- **Service Grid:** 3 columns, white cards with teal icons
- **FAB:** Coral/red circle with white "+"
- **Bottom Nav:** 4 tabs (Home, Bookings, Chat, Profile)

### 7.4 Login Screen
- Logo at top
- Email input field
- Password input field (with show/hide toggle)
- "Forgot Password?" link
- Login button (teal)
- "Create Account" link

### 7.5 Registration Screen
- Step indicator (1-5)
- Back button
- Next/Create Account button
- Form fields per step
- Progress saved between steps

### 7.6 Doctor List Screen
- Search bar at top
- Filter chips (specialization)
- Doctor cards (image, name, specialization, rating)
- Tap to view details

### 7.7 Booking Screen
- Doctor info at top
- Date picker
- Time slot picker
- Appointment type
- Notes field
- Confirm button

### 7.8 Profile Screen
- Profile image (circular)
- User name and role
- Edit profile button
- Menu items (Settings, About, Logout)

### 7.9 Admin Dashboard
- Statistics cards (Users, Doctors, Appointments)
- Charts (user growth, appointments)
- Recent activity list
- Quick actions

---

## 8. Component Architecture

### Common Widgets
```dart
// Custom Button
CustomButton(
  text: "Login",
  onPressed: () {},
  color: Color(0xFF1AA69D),
  textColor: Colors.white,
  borderRadius: 12,
  height: 48,
  width: double.infinity,
  isLoading: false,
  icon: Icons.login,
);

// Custom Text Field
CustomTextField(
  labelText: "Email",
  hintText: "Enter your email",
  prefixIcon: Icons.email_outlined,
  suffixIcon: Icons.visibility_off,
  obscureText: true,
  controller: TextEditingController(),
  validator: (value) => Validators.email(value),
);

// Custom Card
CustomCard(
  child: Column(...),
  borderRadius: 16,
  elevation: 2,
  padding: EdgeInsets.all(16),
);

// Glassmorphism Card
GlassmorphismCard(
  child: Column(...),
  blur: 20,
  opacity: 0.2,
  borderRadius: 16,
);
```

### Navigation Components
```dart
// Custom Drawer
CustomDrawer(
  userName: "John Doe",
  userRole: "Patient",
  profileImage: "https://...",
  menuItems: [...],
  onLogout: () {},
);

// Custom Bottom Nav
CustomBottomNav(
  currentIndex: 0,
  onTap: (index) {},
  items: [
    BottomNavItem(icon: Icons.home, label: "Home"),
    BottomNavItem(icon: Icons.calendar_today, label: "Bookings"),
    BottomNavItem(icon: Icons.chat_bubble_outline, label: "Chat"),
    BottomNavItem(icon: Icons.person_outline, label: "Profile"),
  ],
);
```

---

## 9. Database Schema

### Users Node
```json
{
  "users": {
    "{uid}": {
      "email": "string",
      "phoneNumber": "string",
      "role": "patient|doctor|nurse|pharmacy|vendor",
      "firstName": "string",
      "lastName": "string",
      "fullName": "string",
      "age": "number",
      "weight": "number",
      "height": "number",
      "gender": "male|female|other",
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
  }
}
```

### Doctors Node
```json
{
  "doctors": {
    "{uid}": {
      "specialization": "string",
      "availability": {
        "monday": ["09:00", "10:00", ...],
        "tuesday": [...],
        ...
      },
      "rating": "number",
      "consultationFee": "number",
      "description": "string",
      "qualifications": ["string", ...],
      "experience": "number",
      "clinicAddress": "string",
      "isApproved": "boolean"
    }
  }
}
```

### Appointments Node
```json
{
  "appointments": {
    "{appointmentId}": {
      "patientId": "uid",
      "doctorId": "uid",
      "date": "YYYY-MM-DD",
      "time": "HH:MM",
      "status": "pending|confirmed|completed|cancelled",
      "type": "string",
      "notes": "string",
      "createdAt": "timestamp"
    }
  }
}
```

---

## 10. Upload Flow

### Profile Image Upload
```
1. User taps profile image
2. Show image picker (camera/gallery)
3. Select image
4. Compress image (if needed)
5. Upload to Cloudinary
6. Receive URL response
7. Save URL to Firebase Realtime DB
8. Display image in UI
```

### CNIC Upload
```
1. User taps CNIC upload
2. Show image picker
3. Select front/back image
4. Compress image
5. Upload to Cloudinary
6. Receive URL response
7. Save URL to Firebase Realtime DB
8. Show uploaded image
```

---

## 11. Admin Panel Architecture

### Dashboard
- Total Users (by role)
- Total Appointments
- Revenue (if applicable)
- Pending Verifications
- Charts (line, pie)
- Recent Activity

### User Management
- User list with search/filter
- User details modal
- Approve/Reject buttons
- Suspend/Delete actions
- Export to CSV

### Document Verification
- Pending documents queue
- Image viewer (CNIC front/back)
- Approve/Reject buttons
- Download option

### Splash Management
- Splash type selector
- Video/Image upload
- HTML editor
- Live preview
- Enable/disable toggle

---

## 12. Security Implementation

### Authentication Security
- Firebase Auth with email/password
- Password hashing (Firebase handles)
- Session management
- Auto-logout on inactivity

### Database Security
- Firebase Realtime Database rules
- User can only read/write own data
- Admin-only write for settings
- Server-side validation

### File Upload Security
- File type validation
- File size limits
- Signed URLs for private files
- Cloudinary folder restrictions

---

## 13. Performance Optimization

### Image Optimization
- Compress before upload
- Use Cloudinary transformations
- Implement caching
- Lazy loading

### Database Optimization
- Index frequently queried fields
- Paginate large lists
- Cache frequently accessed data
- Use offline persistence

### App Optimization
- Reduce widget rebuilds
- Use const constructors
- Implement lazy loading
- Profile and optimize hot paths

---

## 14. Testing Strategy

### Unit Tests
- Service functions
- Model serialization
- Validators
- Helpers

### Widget Tests
- Screen rendering
- User interactions
- Form validation
- Navigation

### Integration Tests
- Complete flows
- Authentication
- Booking
- Admin actions

---

## 15. Deployment

### Android
- Generate signed APK/App Bundle
- Configure Play Store listing
- Submit for review
- Monitor crashes and analytics

### iOS (Future)
- Configure signing
- Create App Store listing
- Submit for review
- Monitor crashes and analytics

---

## 16. Future Features

### Phase 2
- [ ] Video consultations
- [ ] In-app messaging
- [ ] Payment integration
- [ ] Prescription management
- [ ] Lab test booking

### Phase 3
- [ ] AI symptom checker
- [ ] Health tracking
- [ ] Wearable integration
- [ ] Multi-language support
- [ ] Dark mode

---

## 17. Success Metrics

### User Engagement
- Daily Active Users (DAU)
- Monthly Active Users (MAU)
- Session duration
- Feature adoption rate

### Business Metrics
- User registration rate
- Appointment booking rate
- Doctor approval rate
- User retention rate

---

## 18. Timeline

| Phase | Duration | Deliverables |
|-------|----------|--------------|
| Phase 1 | 2 weeks | Project setup, authentication |
| Phase 2 | 3 weeks | Core features, home dashboard |
| Phase 3 | 3 weeks | Doctor/appointment screens |
| Phase 4 | 2 weeks | Admin panel |
| Phase 5 | 2 weeks | Testing, optimization |
| **Total** | **12 weeks** | **Production-ready app** |

---

## 19. Resources

### Documentation
- [PROJECT_REQUIREMENTS.md](PROJECT_REQUIREMENTS.md)
- [FIREBASE_SETUP.md](FIREBASE_SETUP.md)
- [CLOUDINARY_SETUP.md](CLOUDINARY_SETUP.md)
- [INSTALLATION.md](INSTALLATION.md)
- [TODO.md](TODO.md)

### External Links
- Flutter Documentation: https://flutter.dev/docs
- Firebase Documentation: https://firebase.google.com/docs
- Cloudinary Documentation: https://cloudinary.com/documentation
- Material 3 Design: https://m3.material.io

---

## 20. Contact

**Project Name:** Homigo Care
**Tagline:** "Because Care Begins at Home"
**Support:** support@homigocare.com

---

This blueprint serves as the complete guide for developing the Homigo Care Medical Healthcare App.
