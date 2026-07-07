import 'package:firebase_database/firebase_database.dart';
import '../config/constants.dart';
import '../models/user_model.dart';
import '../models/doctor_model.dart';
import '../models/appointment_model.dart';
import '../models/notification_model.dart';
import '../models/config_model.dart';

class DatabaseService {
  final FirebaseDatabase _db = FirebaseDatabase.instance;

  // Singleton
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  // ==================== USER OPERATIONS ====================

  Future<void> createUser(UserModel user) async {
    await _db.ref().child('${AppConstants.usersTable}/${user.uid}').set(user.toMap());
  }

  Future<UserModel?> getUser(String uid) async {
    final snapshot = await _db.ref().child('${AppConstants.usersTable}/$uid').get();
    if (snapshot.exists && snapshot.value != null) {
      return UserModel.fromMap(snapshot.value as Map<dynamic, dynamic>, uid);
    }
    return null;
  }

  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    data['updatedAt'] = DateTime.now().millisecondsSinceEpoch;
    await _db.ref().child('${AppConstants.usersTable}/$uid').update(data);
  }

  Future<void> deleteUser(String uid) async {
    await _db.ref().child('${AppConstants.usersTable}/$uid').remove();
  }

  Stream<List<UserModel>> getUsersStream() {
    return _db.ref().child(AppConstants.usersTable).onValue.map((event) {
      List<UserModel> users = [];
      if (event.snapshot.value != null) {
        final data = event.snapshot.value as Map<dynamic, dynamic>;
        data.forEach((key, value) {
          users.add(UserModel.fromMap(value as Map<dynamic, dynamic>, key));
        });
      }
      return users;
    });
  }

  Stream<List<UserModel>> getUsersByRoleStream(String role) {
    return _db.ref().child(AppConstants.usersTable).onValue.map((event) {
      List<UserModel> users = [];
      if (event.snapshot.value != null) {
        final data = event.snapshot.value as Map<dynamic, dynamic>;
        data.forEach((key, value) {
          final user = UserModel.fromMap(value as Map<dynamic, dynamic>, key);
          if (user.role == role) {
            users.add(user);
          }
        });
      }
      return users;
    });
  }

  Future<void> updateUserVerification(String uid, bool isVerified) async {
    await _db.ref().child('${AppConstants.usersTable}/$uid/isVerified').set(isVerified);
  }

  Future<void> updateUserActive(String uid, bool isActive) async {
    await _db.ref().child('${AppConstants.usersTable}/$uid/isActive').set(isActive);
  }

  // ==================== DOCTOR OPERATIONS ====================

  Future<void> createDoctor(DoctorModel doctor) async {
    await _db.ref().child('${AppConstants.doctorsTable}/${doctor.uid}').set(doctor.toMap());
  }

  Future<DoctorModel?> getDoctor(String uid) async {
    final snapshot = await _db.ref().child('${AppConstants.doctorsTable}/$uid').get();
    if (snapshot.exists && snapshot.value != null) {
      return DoctorModel.fromMap(snapshot.value as Map<dynamic, dynamic>, uid);
    }
    return null;
  }

  Future<void> updateDoctor(String uid, Map<String, dynamic> data) async {
    await _db.ref().child('${AppConstants.doctorsTable}/$uid').update(data);
  }

  Future<void> deleteDoctor(String uid) async {
    await _db.ref().child('${AppConstants.doctorsTable}/$uid').remove();
  }

  Stream<List<DoctorModel>> getDoctorsStream() {
    return _db.ref().child(AppConstants.doctorsTable).onValue.map((event) {
      List<DoctorModel> doctors = [];
      if (event.snapshot.value != null) {
        final data = event.snapshot.value as Map<dynamic, dynamic>;
        data.forEach((key, value) {
          doctors.add(DoctorModel.fromMap(value as Map<dynamic, dynamic>, key));
        });
      }
      return doctors;
    });
  }

  Stream<List<DoctorModel>> getApprovedDoctorsStream() {
    return _db.ref().child(AppConstants.doctorsTable).onValue.map((event) {
      List<DoctorModel> doctors = [];
      if (event.snapshot.value != null) {
        final data = event.snapshot.value as Map<dynamic, dynamic>;
        data.forEach((key, value) {
          final doctor = DoctorModel.fromMap(value as Map<dynamic, dynamic>, key);
          if (doctor.isApproved) {
            doctors.add(doctor);
          }
        });
      }
      return doctors;
    });
  }

  Stream<List<DoctorModel>> getDoctorsBySpecializationStream(String specialization) {
    return _db.ref().child(AppConstants.doctorsTable).onValue.map((event) {
      List<DoctorModel> doctors = [];
      if (event.snapshot.value != null) {
        final data = event.snapshot.value as Map<dynamic, dynamic>;
        data.forEach((key, value) {
          final doctor = DoctorModel.fromMap(value as Map<dynamic, dynamic>, key);
          if (doctor.specialization == specialization && doctor.isApproved) {
            doctors.add(doctor);
          }
        });
      }
      return doctors;
    });
  }

  Future<void> approveDoctor(String uid) async {
    await _db.ref().child('${AppConstants.doctorsTable}/$uid/isApproved').set(true);
  }

  // ==================== APPOINTMENT OPERATIONS ====================

  Future<void> createAppointment(AppointmentModel appointment) async {
    await _db.ref()
        .child('${AppConstants.appointmentsTable}/${appointment.appointmentId}')
        .set(appointment.toMap());
  }

  Future<AppointmentModel?> getAppointment(String id) async {
    final snapshot = await _db.ref().child('${AppConstants.appointmentsTable}/$id').get();
    if (snapshot.exists && snapshot.value != null) {
      return AppointmentModel.fromMap(snapshot.value as Map<dynamic, dynamic>, id);
    }
    return null;
  }

  Future<void> updateAppointment(String id, Map<String, dynamic> data) async {
    await _db.ref().child('${AppConstants.appointmentsTable}/$id').update(data);
  }

  Future<void> deleteAppointment(String id) async {
    await _db.ref().child('${AppConstants.appointmentsTable}/$id').remove();
  }

  Stream<List<AppointmentModel>> getAppointmentsStream() {
    return _db.ref().child(AppConstants.appointmentsTable).onValue.map((event) {
      List<AppointmentModel> appointments = [];
      if (event.snapshot.value != null) {
        final data = event.snapshot.value as Map<dynamic, dynamic>;
        data.forEach((key, value) {
          appointments.add(AppointmentModel.fromMap(value as Map<dynamic, dynamic>, key));
        });
      }
      return appointments;
    });
  }

  Stream<List<AppointmentModel>> getPatientAppointmentsStream(String patientId) {
    return _db.ref().child(AppConstants.appointmentsTable).onValue.map((event) {
      List<AppointmentModel> appointments = [];
      if (event.snapshot.value != null) {
        final data = event.snapshot.value as Map<dynamic, dynamic>;
        data.forEach((key, value) {
          final apt = AppointmentModel.fromMap(value as Map<dynamic, dynamic>, key);
          if (apt.patientId == patientId) {
            appointments.add(apt);
          }
        });
      }
      return appointments;
    });
  }

  Stream<List<AppointmentModel>> getDoctorAppointmentsStream(String doctorId) {
    return _db.ref().child(AppConstants.appointmentsTable).onValue.map((event) {
      List<AppointmentModel> appointments = [];
      if (event.snapshot.value != null) {
        final data = event.snapshot.value as Map<dynamic, dynamic>;
        data.forEach((key, value) {
          final apt = AppointmentModel.fromMap(value as Map<dynamic, dynamic>, key);
          if (apt.doctorId == doctorId) {
            appointments.add(apt);
          }
        });
      }
      return appointments;
    });
  }

  // ==================== NOTIFICATION OPERATIONS ====================

  Future<void> createNotification(NotificationModel notification) async {
    await _db.ref()
        .child('${AppConstants.notificationsTable}/${notification.notificationId}')
        .set(notification.toMap());
  }

  Stream<List<NotificationModel>> getNotificationsStream() {
    return _db.ref().child(AppConstants.notificationsTable).onValue.map((event) {
      List<NotificationModel> notifications = [];
      if (event.snapshot.value != null) {
        final data = event.snapshot.value as Map<dynamic, dynamic>;
        data.forEach((key, value) {
          notifications.add(NotificationModel.fromMap(value as Map<dynamic, dynamic>, key));
        });
      }
      return notifications;
    });
  }

  Future<void> markNotificationRead(String id) async {
    await _db.ref().child('${AppConstants.notificationsTable}/$id/isRead').set(true);
  }

  Future<void> deleteNotification(String id) async {
    await _db.ref().child('${AppConstants.notificationsTable}/$id').remove();
  }

  // ==================== SETTINGS OPERATIONS ====================

  Future<AppSettings> getSettings() async {
    final snapshot = await _db.ref().child(AppConstants.settingsTable).get();
    if (snapshot.exists && snapshot.value != null) {
      return AppSettings.fromMap(snapshot.value as Map<dynamic, dynamic>);
    }
    return AppSettings();
  }

  Stream<AppSettings> getSettingsStream() {
    return _db.ref().child(AppConstants.settingsTable).onValue.map((event) {
      if (event.snapshot.value != null) {
        return AppSettings.fromMap(event.snapshot.value as Map<dynamic, dynamic>);
      }
      return AppSettings();
    });
  }

  Future<void> updateSettings(Map<String, dynamic> data) async {
    await _db.ref().child(AppConstants.settingsTable).update(data);
  }

  // ==================== SPLASH OPERATIONS ====================

  Future<SplashConfig> getSplashConfig() async {
    final snapshot = await _db.ref().child(AppConstants.splashTable).get();
    if (snapshot.exists && snapshot.value != null) {
      return SplashConfig.fromMap(snapshot.value as Map<dynamic, dynamic>);
    }
    return SplashConfig();
  }

  Stream<SplashConfig> getSplashStream() {
    return _db.ref().child(AppConstants.splashTable).onValue.map((event) {
      if (event.snapshot.value != null) {
        return SplashConfig.fromMap(event.snapshot.value as Map<dynamic, dynamic>);
      }
      return SplashConfig();
    });
  }

  Future<void> updateSplashConfig(Map<String, dynamic> data) async {
    await _db.ref().child(AppConstants.splashTable).update(data);
  }

  // ==================== BANNER OPERATIONS ====================

  Stream<List<BannerModel>> getBannersStream() {
    return _db.ref().child(AppConstants.bannersTable).onValue.map((event) {
      List<BannerModel> banners = [];
      if (event.snapshot.value != null) {
        final data = event.snapshot.value as Map<dynamic, dynamic>;
        data.forEach((key, value) {
          final banner = BannerModel.fromMap(value as Map<dynamic, dynamic>, key);
          if (banner.isActive) {
            banners.add(banner);
          }
        });
        banners.sort((a, b) => a.order.compareTo(b.order));
      }
      return banners;
    });
  }

  Future<void> createBanner(BannerModel banner) async {
    await _db.ref().child('${AppConstants.bannersTable}/${banner.bannerId}').set(banner.toMap());
  }

  Future<void> updateBanner(String id, Map<String, dynamic> data) async {
    await _db.ref().child('${AppConstants.bannersTable}/$id').update(data);
  }

  Future<void> deleteBanner(String id) async {
    await _db.ref().child('${AppConstants.bannersTable}/$id').remove();
  }

  // ==================== STATS ====================

  Future<Map<String, int>> getStats() async {
    final usersSnapshot = await _db.ref().child(AppConstants.usersTable).get();
    final appointmentsSnapshot = await _db.ref().child(AppConstants.appointmentsTable).get();

    int totalUsers = 0;
    int totalPatients = 0;
    int totalDoctors = 0;
    int totalNurses = 0;
    int totalPharmacies = 0;
    int totalAppointments = 0;

    if (usersSnapshot.exists && usersSnapshot.value != null) {
      final data = usersSnapshot.value as Map<dynamic, dynamic>;
      totalUsers = data.length;
      data.forEach((key, value) {
        final role = (value as Map<dynamic, dynamic>)['role']?.toString() ?? '';
        switch (role) {
          case 'patient':
            totalPatients++;
            break;
          case 'doctor':
            totalDoctors++;
            break;
          case 'nurse':
            totalNurses++;
            break;
          case 'pharmacy':
            totalPharmacies++;
            break;
        }
      });
    }

    if (appointmentsSnapshot.exists && appointmentsSnapshot.value != null) {
      totalAppointments = (appointmentsSnapshot.value as Map).length;
    }

    return {
      'totalUsers': totalUsers,
      'totalPatients': totalPatients,
      'totalDoctors': totalDoctors,
      'totalNurses': totalNurses,
      'totalPharmacies': totalPharmacies,
      'totalAppointments': totalAppointments,
    };
  }
}
