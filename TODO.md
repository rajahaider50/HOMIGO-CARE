# TODO — Homigo Care Development Tasks

## Project Status: 🟡 In Progress

---

## Phase 1: Project Setup & Configuration

### Documentation
- [x] Create PROJECT_REQUIREMENTS.md
- [x] Create FIREBASE_SETUP.md
- [x] Create CLOUDINARY_SETUP.md
- [x] Create firebase_security_rules.txt
- [x] Create INSTALLATION.md
- [x] Create TODO.md
- [x] Create CHANGELOG.md
- [x] Create PROJECT_BLUEPRINT.md

### Firebase Setup
- [ ] Create Firebase project
- [ ] Register Android app
- [ ] Download google-services.json
- [ ] Place google-services.json in android/app/
- [ ] Enable Email/Password authentication
- [ ] Create Realtime Database
- [ ] Deploy security rules
- [ ] Generate SHA-1/SHA-256 keys
- [ ] Test Firebase connection

### Cloudinary Setup
- [ ] Create Cloudinary account
- [ ] Get API credentials
- [ ] Create upload presets
- [ ] Create folder structure
- [ ] Test upload functionality
- [ ] Configure Flutter integration

### Android Configuration
- [ ] Update build.gradle files
- [ ] Add required permissions
- [ ] Configure app signing
- [ ] Test on Android device/emulator

---

## Phase 2: Flutter Project Structure

### Core Files
- [ ] Create main.dart with Firebase initialization
- [ ] Create app.dart with MaterialApp configuration
- [ ] Create firebase_options.dart (or configure manually)
- [ ] Create theme.dart with Homigo Care theme
- [ ] Create routes.dart with named routes
- [ ] Create constants.dart with app constants

### Folder Structure
- [ ] Create lib/models/ folder
- [ ] Create lib/services/ folder
- [ ] Create lib/providers/ folder
- [ ] Create lib/screens/ folder
- [ ] Create lib/widgets/ folder
- [ ] Create lib/utils/ folder
- [ ] Create assets/ folder structure

---

## Phase 3: Models

### User Models
- [ ] Create user_model.dart
- [ ] Create doctor_model.dart
- [ ] Create appointment_model.dart
- [ ] Create notification_model.dart
- [ ] Create splash_model.dart
- [ ] Create banner_model.dart

---

## Phase 4: Services

### Authentication
- [ ] Create auth_service.dart
- [ ] Implement email/password sign-in
- [ ] Implement email/password registration
- [ ] Implement password reset
- [ ] Implement sign-out
- [ ] Implement session management

### Database
- [ ] Create database_service.dart
- [ ] Implement user CRUD operations
- [ ] Implement doctor CRUD operations
- [ ] Implement appointment CRUD operations
- [ ] Implement notification CRUD operations
- [ ] Implement settings operations

### Cloudinary
- [ ] Create cloudinary_service.dart
- [ ] Implement image upload
- [ ] Implement document upload
- [ ] Implement video upload
- [ ] Implement file deletion
- [ ] Implement URL generation

### Notifications
- [ ] Create notification_service.dart
- [ ] Implement push notification setup
- [ ] Implement local notifications
- [ ] Implement notification handling

---

## Phase 5: Providers

### State Management
- [ ] Create auth_provider.dart
- [ ] Create user_provider.dart
- [ ] Create doctor_provider.dart
- [ ] Create appointment_provider.dart
- [ ] Create theme_provider.dart
- [ ] Create splash_provider.dart

---

## Phase 6: Splash Screen System

### Splash Types
- [ ] Create splash_screen.dart (main controller)
- [ ] Create splash_type1.dart (default animation)
- [ ] Create splash_type2.dart (video splash)
- [ ] Create splash_type3.dart (image splash)
- [ ] Create splash_type4.dart (HTML/text splash)
- [ ] Implement auto-navigation
- [ ] Implement admin control

---

## Phase 7: Authentication Screens

### Login
- [ ] Create login_screen.dart
- [ ] Add email input field
- [ ] Add password input field
- [ ] Add show/hide password toggle
- [ ] Add forgot password link
- [ ] Add login button
- [ ] Add form validation
- [ ] Add error handling
- [ ] Add loading states

### Registration
- [ ] Create registration_screen.dart
- [ ] Implement step navigation
- [ ] Add progress indicator

### Registration Steps
- [ ] Create step1_role_selection.dart
- [ ] Create step2_personal_details.dart
- [ ] Create step3_verification.dart
- [ ] Create step4_medical_info.dart
- [ ] Create step5_account_creation.dart

### Forgot Password
- [ ] Create forgot_password_screen.dart
- [ ] Add email input
- [ ] Add send reset link button
- [ ] Add success message

---

## Phase 8: Home Screen

### Main Dashboard
- [ ] Create home_screen.dart
- [ ] Create home_dashboard.dart
- [ ] Add logo and branding
- [ ] Add search bar
- [ ] Add service grid
- [ ] Add slider/banner section
- [ ] Add emergency button
- [ ] Add FAB (Floating Action Button)

### Components
- [ ] Create search_bar.dart widget
- [ ] Create service_grid.dart widget
- [ ] Create slider_banner.dart widget
- [ ] Create featured_doctors.dart widget
- [ ] Create emergency_button.dart widget

---

## Phase 9: Navigation

### Drawer
- [ ] Create custom_drawer.dart
- [ ] Add profile section
- [ ] Add menu items
- [ ] Add logout button
- [ ] Add styling

### Bottom Navigation
- [ ] Create custom_bottom_nav.dart
- [ ] Add Home tab
- [ ] Add Bookings tab
- [ ] Add Chat tab
- [ ] Add Profile tab
- [ ] Add active/inactive states

---

## Phase 10: Doctor Screens

### Doctor Listing
- [ ] Create doctors_list_screen.dart
- [ ] Add doctor cards
- [ ] Add search/filter
- [ ] Add specialization filter
- [ ] Add loading states
- [ ] Add empty states

### Doctor Details
- [ ] Create doctor_detail_screen.dart
- [ ] Add doctor profile info
- [ ] Add availability schedule
- [ ] Add book appointment button
- [ ] Add reviews section

### Search
- [ ] Create search_doctors_screen.dart
- [ ] Add search input
- [ ] Add search results
- [ ] Add recent searches

---

## Phase 11: Appointment Screens

### Booking
- [ ] Create booking_screen.dart
- [ ] Add date picker
- [ ] Add time slot picker
- [ ] Add appointment type selection
- [ ] Add notes field
- [ ] Add confirm booking button

### Appointments List
- [ ] Create appointments_screen.dart
- [ ] Add upcoming appointments
- [ ] Add past appointments
- [ ] Add status filters
- [ ] Add appointment cards

### Appointment Details
- [ ] Create appointment_detail_screen.dart
- [ ] Add appointment info
- [ ] Add cancel/reschedule options
- [ ] Add doctor info

---

## Phase 12: Profile Screens

### Profile View
- [ ] Create profile_screen.dart
- [ ] Add profile image
- [ ] Add user info
- [ ] Add edit profile button
- [ ] Add logout button

### Edit Profile
- [ ] Create edit_profile_screen.dart
- [ ] Add image picker
- [ ] Add form fields
- [ ] Add save button
- [ ] Add validation

---

## Phase 13: Notification Screen

- [ ] Create notifications_screen.dart
- [ ] Add notification list
- [ ] Add mark as read
- [ ] Add delete option
- [ ] Add empty state

---

## Phase 14: Settings Screens

### Settings
- [ ] Create settings_screen.dart
- [ ] Add theme toggle
- [ ] Add notification settings
- [ ] Add about link
- [ ] Add privacy policy link
- [ ] Add terms link

### About
- [ ] Create about_screen.dart
- [ ] Add app info
- [ ] Add version info
- [ ] Add developer info

### Privacy Policy
- [ ] Create privacy_policy_screen.dart
- [ ] Add policy content

---

## Phase 15: Common Widgets

### Reusable Components
- [ ] Create custom_button.dart
- [ ] Create custom_text_field.dart
- [ ] Create custom_card.dart
- [ ] Create loading_widget.dart
- [ ] Create error_widget.dart
- [ ] Create empty_state_widget.dart
- [ ] Create glassmorphism_card.dart

---

## Phase 16: Admin Panel

### Admin Dashboard
- [ ] Create admin_dashboard_screen.dart
- [ ] Add statistics cards
- [ ] Add charts
- [ ] Add recent activity
- [ ] Add quick actions

### User Management
- [ ] Create user_management_screen.dart
- [ ] Add user list
- [ ] Add search/filter
- [ ] Add approve/reject actions
- [ ] Add suspend/delete actions
- [ ] Add export functionality

### Doctor Management
- [ ] Create doctor_management_screen.dart
- [ ] Add doctor list
- [ ] Add approval workflow
- [ ] Add specialization management
- [ ] Add availability management

### Document Verification
- [ ] Create document_verification_screen.dart
- [ ] Add pending documents list
- [ ] Add document viewer
- [ ] Add approve/reject buttons
- [ ] Add download option

### Appointment Management
- [ ] Create appointment_management_screen.dart
- [ ] Add all appointments list
- [ ] Add status filters
- [ ] Add create appointment
- [ ] Add cancel appointment

### Splash Management
- [ ] Create splash_management_screen.dart
- [ ] Add splash type selector
- [ ] Add video upload
- [ ] Add image upload
- [ ] Add HTML editor
- [ ] Add live preview
- [ ] Add enable/disable toggle

### Notification Management
- [ ] Create notification_management_screen.dart
- [ ] Add create notification form
- [ ] Add notification list
- [ ] Add edit/delete options
- [ ] Add target audience selection

### App Settings
- [ ] Create app_settings_screen.dart
- [ ] Add app name setting
- [ ] Add logo upload
- [ ] Add color settings
- [ ] Add support info
- [ ] Add maintenance mode toggle

---

## Phase 17: Utilities

### Helpers
- [ ] Create validators.dart
- [ ] Create formatters.dart
- [ ] Create helpers.dart
- [ ] Create extensions.dart

---

## Phase 18: Assets

### Logo
- [ ] Copy logo.png to assets/logo/
- [ ] Copy simple.jpg to assets/logo/
- [ ] Generate app icons in all sizes

### Icons
- [ ] Create/find patient icon (SVG)
- [ ] Create/find nurse icon (SVG)
- [ ] Create/find doctor icon (SVG)
- [ ] Create/find lab icon (SVG)
- [ ] Create/find pharmacy icon (SVG)
- [ ] Create/find vendor icon (SVG)

### Images
- [ ] Add placeholder images
- [ ] Add empty state images
- [ ] Add loading animations

---

## Phase 19: Testing

### Unit Tests
- [ ] Write auth service tests
- [ ] Write database service tests
- [ ] Write cloudinary service tests
- [ ] Write validator tests
- [ ] Write helper tests

### Widget Tests
- [ ] Write login screen tests
- [ ] Write registration screen tests
- [ ] Write home screen tests
- [ ] Write doctor list tests
- [ ] Write booking screen tests

### Integration Tests
- [ ] Write registration flow test
- [ ] Write login flow test
- [ ] Write booking flow test
- [ ] Write admin flow test

---

## Phase 20: Production Preparation

### Performance
- [ ] Optimize images
- [ ] Implement caching
- [ ] Reduce bundle size
- [ ] Profile app performance

### Security
- [ ] Review Firebase rules
- [ ] Test authentication flows
- [ ] Validate inputs
- [ ] Check for vulnerabilities

### Documentation
- [ ] Update README.md
- [ ] Add code comments
- [ ] Document API endpoints
- [ ] Create user guide

### Release
- [ ] Generate signed APK
- [ ] Generate App Bundle
- [ ] Prepare Play Store listing
- [ ] Create screenshots
- [ ] Write app description
- [ ] Submit for review

---

## Priority Order

### High Priority (Phase 1-7)
1. Project setup
2. Firebase & Cloudinary configuration
3. Authentication system
4. Splash screen
5. Login/Registration

### Medium Priority (Phase 8-14)
6. Home dashboard
7. Navigation
8. Doctor screens
9. Appointment booking
10. Profile management

### Lower Priority (Phase 15-20)
11. Admin panel
12. Common widgets
13. Utilities
14. Testing
15. Production prep

---

## Notes

- Test each phase before moving to next
- Commit code after each phase
- Document any issues encountered
- Update this TODO as tasks are completed
