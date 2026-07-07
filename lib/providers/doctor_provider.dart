import 'package:flutter/material.dart';
import '../services/database_service.dart';
import '../models/doctor_model.dart';

class DoctorProvider extends ChangeNotifier {
  final DatabaseService _dbService = DatabaseService();

  List<DoctorModel> _doctors = [];
  List<DoctorModel> _approvedDoctors = [];
  DoctorModel? _selectedDoctor;
  bool _isLoading = false;
  String? _error;
  String _searchQuery = '';
  String _selectedSpecialization = '';

  List<DoctorModel> get doctors => _doctors;
  List<DoctorModel> get approvedDoctors => _approvedDoctors;
  DoctorModel? get selectedDoctor => _selectedDoctor;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get searchQuery => _searchQuery;
  String get selectedSpecialization => _selectedSpecialization;

  List<DoctorModel> get filteredDoctors {
    List<DoctorModel> filtered = _approvedDoctors;

    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((d) =>
          d.specialization.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          d.clinicAddress.toLowerCase().contains(_searchQuery.toLowerCase())
      ).toList();
    }

    if (_selectedSpecialization.isNotEmpty) {
      filtered = filtered.where((d) =>
          d.specialization == _selectedSpecialization
      ).toList();
    }

    return filtered;
  }

  // Load all doctors
  void loadDoctors() {
    _isLoading = true;
    notifyListeners();

    _dbService.getDoctorsStream().listen((doctors) {
      _doctors = doctors;
      _isLoading = false;
      notifyListeners();
    });
  }

  // Load approved doctors
  void loadApprovedDoctors() {
    _dbService.getApprovedDoctorsStream().listen((doctors) {
      _approvedDoctors = doctors;
      notifyListeners();
    });
  }

  // Load doctor by ID
  Future<void> loadDoctor(String uid) async {
    _isLoading = true;
    notifyListeners();

    try {
      _selectedDoctor = await _dbService.getDoctor(uid);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Create doctor profile
  Future<bool> createDoctor(DoctorModel doctor) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _dbService.createDoctor(doctor);
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

  // Update doctor
  Future<bool> updateDoctor(String uid, Map<String, dynamic> data) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _dbService.updateDoctor(uid, data);
      if (_selectedDoctor != null && _selectedDoctor!.uid == uid) {
        _selectedDoctor = await _dbService.getDoctor(uid);
      }
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

  // Approve doctor (admin)
  Future<bool> approveDoctor(String uid) async {
    try {
      await _dbService.approveDoctor(uid);
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  // Delete doctor (admin)
  Future<bool> deleteDoctor(String uid) async {
    try {
      await _dbService.deleteDoctor(uid);
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  // Search
  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setSelectedSpecialization(String spec) {
    _selectedSpecialization = spec;
    notifyListeners();
  }

  void clearFilters() {
    _searchQuery = '';
    _selectedSpecialization = '';
    notifyListeners();
  }
}
