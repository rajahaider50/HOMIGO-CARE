import 'package:flutter/material.dart';
import '../services/database_service.dart';
import '../services/cloudinary_service.dart';
import '../models/user_model.dart';

class UserProvider extends ChangeNotifier {
  final DatabaseService _dbService = DatabaseService();
  final CloudinaryService _cloudinaryService = CloudinaryService();

  UserModel? _currentUser;
  List<UserModel> _users = [];
  bool _isLoading = false;
  String? _error;

  UserModel? get currentUser => _currentUser;
  List<UserModel> get users => _users;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadCurrentUser(String uid) async {
    _isLoading = true;
    notifyListeners();

    try {
      _currentUser = await _dbService.getUser(uid);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createUser(UserModel user) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _dbService.createUser(user);
      _currentUser = user;
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

  Future<bool> updateUser(String uid, Map<String, dynamic> data) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _dbService.updateUser(uid, data);
      if (_currentUser != null && _currentUser!.uid == uid) {
        _currentUser = await _dbService.getUser(uid);
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

  Future<String?> uploadProfileImage(String uid, String filePath) async {
    try {
      final response = await _cloudinaryService.uploadImage(
        filePath: filePath,
        folder: 'homigo-care/profiles',
      );

      if (response != null && response['secure_url'] != null) {
        final url = response['secure_url'] as String;
        await _dbService.updateUser(uid, {'profileImage': url});
        _currentUser = await _dbService.getUser(uid);
        notifyListeners();
        return url;
      }
      return null;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return null;
    }
  }

  Future<String?> uploadCnic(String uid, String filePath, bool isFront) async {
    try {
      final response = await _cloudinaryService.uploadImage(
        filePath: filePath,
        folder: 'homigo-care/cnic',
      );

      if (response != null && response['secure_url'] != null) {
        final url = response['secure_url'] as String;
        final field = isFront ? 'cnicFront' : 'cnicBack';
        await _dbService.updateUser(uid, {field: url});
        _currentUser = await _dbService.getUser(uid);
        notifyListeners();
        return url;
      }
      return null;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return null;
    }
  }

  void loadAllUsers() {
    _dbService.getUsersStream().listen((users) {
      _users = users;
      notifyListeners();
    });
  }

  void loadUsersByRole(String role) {
    _dbService.getUsersByRoleStream(role).listen((users) {
      _users = users;
      notifyListeners();
    });
  }

  Future<bool> verifyUser(String uid) async {
    try {
      await _dbService.updateUserVerification(uid, true);
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> suspendUser(String uid) async {
    try {
      await _dbService.updateUserActive(uid, false);
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteUser(String uid) async {
    try {
      await _dbService.deleteUser(uid);
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
