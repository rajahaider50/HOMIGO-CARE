import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../services/database_service.dart';
import '../models/appointment_model.dart';

class AppointmentProvider extends ChangeNotifier {
  final DatabaseService _dbService = DatabaseService();
  final _uuid = const Uuid();

  List<AppointmentModel> _appointments = [];
  List<AppointmentModel> _patientAppointments = [];
  List<AppointmentModel> _doctorAppointments = [];
  AppointmentModel? _selectedAppointment;
  bool _isLoading = false;
  String? _error;
  String _statusFilter = '';

  List<AppointmentModel> get appointments => _appointments;
  List<AppointmentModel> get patientAppointments => _patientAppointments;
  List<AppointmentModel> get doctorAppointments => _doctorAppointments;
  AppointmentModel? get selectedAppointment => _selectedAppointment;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get statusFilter => _statusFilter;

  List<AppointmentModel> get filteredAppointments {
    if (_statusFilter.isEmpty) return _appointments;
    return _appointments.where((a) => a.status == _statusFilter).toList();
  }

  // Load all appointments
  void loadAppointments() {
    _dbService.getAppointmentsStream().listen((appointments) {
      _appointments = appointments;
      notifyListeners();
    });
  }

  // Load patient appointments
  void loadPatientAppointments(String patientId) {
    _dbService.getPatientAppointmentsStream(patientId).listen((appointments) {
      _patientAppointments = appointments;
      notifyListeners();
    });
  }

  // Load doctor appointments
  void loadDoctorAppointments(String doctorId) {
    _dbService.getDoctorAppointmentsStream(doctorId).listen((appointments) {
      _doctorAppointments = appointments;
      notifyListeners();
    });
  }

  // Create appointment
  Future<bool> createAppointment({
    required String patientId,
    required String doctorId,
    required String date,
    required String time,
    String type = 'consultation',
    String notes = '',
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final appointment = AppointmentModel(
        appointmentId: _uuid.v4(),
        patientId: patientId,
        doctorId: doctorId,
        date: date,
        time: time,
        status: 'pending',
        type: type,
        notes: notes,
        createdAt: DateTime.now(),
      );

      await _dbService.createAppointment(appointment);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Update appointment status
  Future<bool> updateStatus(String id, String status) async {
    try {
      await _dbService.updateAppointment(id, {'status': status});
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  // Cancel appointment
  Future<bool> cancelAppointment(String id) async {
    return updateStatus(id, 'cancelled');
  }

  // Confirm appointment
  Future<bool> confirmAppointment(String id) async {
    return updateStatus(id, 'confirmed');
  }

  // Complete appointment
  Future<bool> completeAppointment(String id) async {
    return updateStatus(id, 'completed');
  }

  // Delete appointment
  Future<bool> deleteAppointment(String id) async {
    try {
      await _dbService.deleteAppointment(id);
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  // Set status filter
  void setStatusFilter(String status) {
    _statusFilter = status;
    notifyListeners();
  }

  void clearFilters() {
    _statusFilter = '';
    notifyListeners();
  }
}
