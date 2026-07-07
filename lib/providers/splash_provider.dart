import 'package:flutter/material.dart';
import '../services/database_service.dart';
import '../models/config_model.dart';

class SplashProvider extends ChangeNotifier {
  final DatabaseService _dbService = DatabaseService();

  SplashConfig _splashConfig = SplashConfig();
  AppSettings _appSettings = AppSettings();
  bool _isLoading = false;

  SplashConfig get splashConfig => _splashConfig;
  AppSettings get appSettings => _appSettings;
  bool get isLoading => _isLoading;

  SplashProvider() {
    loadSplashConfig();
    loadSettings();
  }

  Future<void> loadSplashConfig() async {
    _isLoading = true;
    notifyListeners();

    try {
      _splashConfig = await _dbService.getSplashConfig();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _splashConfig = SplashConfig();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadSettings() async {
    try {
      _appSettings = await _dbService.getSettings();
      notifyListeners();
    } catch (e) {
      _appSettings = AppSettings();
      notifyListeners();
    }
  }

  // Admin: Update splash config
  Future<bool> updateSplashConfig(Map<String, dynamic> data) async {
    try {
      await _dbService.updateSplashConfig(data);
      await loadSplashConfig();
      return true;
    } catch (e) {
      return false;
    }
  }

  // Admin: Update settings
  Future<bool> updateSettings(Map<String, dynamic> data) async {
    try {
      await _dbService.updateSettings(data);
      await loadSettings();
      return true;
    } catch (e) {
      return false;
    }
  }
}
