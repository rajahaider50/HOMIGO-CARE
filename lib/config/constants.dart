class AppConstants {
  static const String appName = 'Homigo Care';
  static const String appTagline = 'Because Care Begins at Home';
  static const String appVersion = '1.0.0';

  // Firebase
  static const String usersTable = 'users';
  static const String doctorsTable = 'doctors';
  static const String appointmentsTable = 'appointments';
  static const String notificationsTable = 'notifications';
  static const String settingsTable = 'settings';
  static const String splashTable = 'splash';
  static const String bannersTable = 'banners';
  static const String chatsTable = 'chats';

  // Cloudinary
  static const String cloudinaryCloudName = 'dtpuqzq0e';
  static const String cloudinaryUploadPreset = 'homigo_care_upload';
  static const String cloudinaryApiKey = '688456111861478';

  // Roles
  static const String rolePatient = 'patient';
  static const String roleDoctor = 'doctor';
  static const String roleNurse = 'nurse';
  static const String rolePharmacy = 'pharmacy';
  static const String roleVendor = 'vendor';
  static const String roleAdmin = 'admin';

  // Appointment Status
  static const String statusPending = 'pending';
  static const String statusConfirmed = 'confirmed';
  static const String statusCompleted = 'completed';
  static const String statusCancelled = 'cancelled';

  // Splash Types
  static const int splashTypeDefault = 1;
  static const int splashTypeVideo = 2;
  static const int splashTypeImage = 3;
  static const int splashTypeHtml = 4;

  // Image folders
  static const String folderProfiles = 'homigo-care/profiles';
  static const String folderCnic = 'homigo-care/cnic';
  static const String folderDoctors = 'homigo-care/doctors';
  static const String folderBanners = 'homigo-care/banners';
  static const String folderSplash = 'homigo-care/splash';
  static const String folderDocuments = 'homigo-care/documents';

  // Specializations
  static const List<String> specializations = [
    'General Physician',
    'Cardiologist',
    'Dermatologist',
    'Endocrinologist',
    'Gastroenterologist',
    'Neurologist',
    'Oncologist',
    'Ophthalmologist',
    'Orthopedic',
    'Pediatrician',
    'Psychiatrist',
    'Pulmonologist',
    'Urologist',
    'Gynecologist',
    'ENT Specialist',
  ];

  // Days of week
  static const List<String> daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
}
