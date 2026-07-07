import 'package:flutter/material.dart';
import '../screens/splash/splash_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/forgot_password_screen.dart';
import '../screens/registration/role_selection_screen.dart';
import '../screens/registration/personal_details_screen.dart';
import '../screens/registration/verification_screen.dart';
import '../screens/registration/medical_info_screen.dart';
import '../screens/registration/account_creation_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/doctors/doctors_list_screen.dart';
import '../screens/doctors/doctor_detail_screen.dart';
import '../screens/appointments/booking_screen.dart';
import '../screens/appointments/appointments_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/profile/edit_profile_screen.dart';
import '../screens/notifications/notifications_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../screens/settings/about_screen.dart';
import '../screens/admin/admin_dashboard_screen.dart';
import '../screens/chat/chat_screen.dart';
import '../screens/debug/diagnostics_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String forgotPassword = '/forgot-password';
  static const String roleSelection = '/role-selection';
  static const String personalDetails = '/personal-details';
  static const String verification = '/verification';
  static const String medicalInfo = '/medical-info';
  static const String accountCreation = '/account-creation';
  static const String home = '/home';
  static const String doctorsList = '/doctors';
  static const String doctorDetail = '/doctor-detail';
  static const String booking = '/booking';
  static const String appointments = '/appointments';
  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';
  static const String notifications = '/notifications';
  static const String settings = '/settings';
  static const String about = '/about';
  static const String adminDashboard = '/admin-dashboard';
  static const String chat = '/chat';
  static const String diagnostics = '/diagnostics';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case roleSelection:
        return MaterialPageRoute(builder: (_) => const RoleSelectionScreen());
      case personalDetails:
        return MaterialPageRoute(builder: (_) => const PersonalDetailsScreen());
      case verification:
        return MaterialPageRoute(builder: (_) => const VerificationScreen());
      case medicalInfo:
        return MaterialPageRoute(builder: (_) => const MedicalInfoScreen());
      case accountCreation:
        return MaterialPageRoute(builder: (_) => const AccountCreationScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case doctorsList:
        return MaterialPageRoute(builder: (_) => const DoctorsListScreen());
      case doctorDetail:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => DoctorDetailScreen(doctorId: args?['doctorId'] ?? ''),
        );
      case booking:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => BookingScreen(doctorId: args?['doctorId'] ?? ''),
        );
      case appointments:
        return MaterialPageRoute(builder: (_) => const AppointmentsScreen());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case editProfile:
        return MaterialPageRoute(builder: (_) => const EditProfileScreen());
      case notifications:
        return MaterialPageRoute(builder: (_) => const NotificationsScreen());
      case settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case about:
        return MaterialPageRoute(builder: (_) => const AboutScreen());
      case adminDashboard:
        return MaterialPageRoute(builder: (_) => const AdminDashboardScreen());
      case chat:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => ChatScreen(chatId: args?['chatId'] ?? ''),
        );
      case diagnostics:
        return MaterialPageRoute(builder: (_) => const DiagnosticsScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
