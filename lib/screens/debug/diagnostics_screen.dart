import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../config/theme.dart';
import '../../config/constants.dart';

class DiagnosticsScreen extends StatefulWidget {
  const DiagnosticsScreen({super.key});

  @override
  State<DiagnosticsScreen> createState() => _DiagnosticsScreenState();
}

class _DiagnosticsScreenState extends State<DiagnosticsScreen> {
  final List<DiagnosticsResult> _results = [];
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _runDiagnostics();
  }

  Future<void> _runDiagnostics() async {
    setState(() {
      _isRunning = true;
      _results.clear();
    });

    // Check Firebase Auth
    await _checkFirebaseAuth();
    // Check Firebase Database
    await _checkFirebaseDatabase();
    // Check Cloudinary Config
    await _checkCloudinaryConfig();
    // Check Platform
    await _checkPlatform();
    // Check Internet
    await _checkInternet();
    // Check App Config
    await _checkAppConfig();

    setState(() => _isRunning = false);
  }

  Future<void> _checkFirebaseAuth() async {
    try {
      final auth = FirebaseAuth.instance;
      final user = auth.currentUser;
      _results.add(DiagnosticsResult(
        category: 'Firebase Authentication',
        status: user != null ? DiagnosticStatus.success : DiagnosticStatus.warning,
        message: user != null
            ? 'Connected - User: ${user.email ?? user.uid}'
            : 'Connected - No user signed in',
        details: 'Email/Password, Phone, Google, Anonymous',
      ));
    } catch (e) {
      _results.add(DiagnosticsResult(
        category: 'Firebase Authentication',
        status: DiagnosticStatus.error,
        message: 'Connection failed',
        details: e.toString(),
      ));
    }
  }

  Future<void> _checkFirebaseDatabase() async {
    try {
      final db = FirebaseDatabase.instance;
      final ref = db.ref();
      final snapshot = await ref.child(AppConstants.settingsTable).get();
      _results.add(DiagnosticsResult(
        category: 'Firebase Realtime Database',
        status: DiagnosticStatus.success,
        message: 'Connected',
        details: 'Database: homigo-care-8360e',
      ));
    } catch (e) {
      _results.add(DiagnosticsResult(
        category: 'Firebase Realtime Database',
        status: DiagnosticStatus.error,
        message: 'Connection failed',
        details: e.toString(),
      ));
    }
  }

  Future<void> _checkCloudinaryConfig() async {
    final hasCloudName = AppConstants.cloudinaryCloudName.isNotEmpty;
    final hasApiKey = AppConstants.cloudinaryApiKey.isNotEmpty;
    final hasPreset = AppConstants.cloudinaryUploadPreset.isNotEmpty;

    if (hasCloudName && hasApiKey && hasPreset) {
      _results.add(DiagnosticsResult(
        category: 'Cloudinary Configuration',
        status: DiagnosticStatus.success,
        message: 'Configured',
        details: 'Cloud: ${AppConstants.cloudinaryCloudName}',
      ));
    } else {
      _results.add(DiagnosticsResult(
        category: 'Cloudinary Configuration',
        status: DiagnosticStatus.error,
        message: 'Incomplete configuration',
        details: 'Missing: ${!hasCloudName ? "Cloud Name " : ""}${!hasApiKey ? "API Key " : ""}${!hasPreset ? "Upload Preset" : ""}',
      ));
    }
  }

  Future<void> _checkPlatform() async {
    String platform;
    if (kIsWeb) {
      platform = 'Web';
    } else if (Platform.isAndroid) {
      platform = 'Android';
    } else if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Unknown';
    }

    _results.add(DiagnosticsResult(
      category: 'Platform',
      status: DiagnosticStatus.success,
      message: platform,
      details: 'Flutter: ${kDebugMode ? "Debug" : "Release"}',
    ));
  }

  Future<void> _checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _results.add(DiagnosticsResult(
          category: 'Internet Connection',
          status: DiagnosticStatus.success,
          message: 'Connected',
          details: 'DNS resolved successfully',
        ));
      }
    } catch (e) {
      _results.add(DiagnosticsResult(
        category: 'Internet Connection',
        status: DiagnosticStatus.error,
        message: 'No internet connection',
        details: e.toString(),
      ));
    }
  }

  Future<void> _checkAppConfig() async {
    _results.add(DiagnosticsResult(
      category: 'App Configuration',
      status: DiagnosticStatus.success,
      message: 'Configured',
      details: 'Name: ${AppConstants.appName}\nVersion: ${AppConstants.appVersion}',
    ));

    // Check assets
    _results.add(DiagnosticsResult(
      category: 'Assets',
      status: DiagnosticStatus.warning,
      message: 'Manual verification required',
      details: 'Verify logo.png, icons, and images exist in assets/',
    ));

    // Check localization
    _results.add(DiagnosticsResult(
      category: 'Localization',
      status: DiagnosticStatus.info,
      message: 'Not configured',
      details: 'Add localization support for multi-language',
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Developer Console'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _runDiagnostics,
          ),
        ],
      ),
      body: _isRunning
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: AppColors.primaryTeal),
                  SizedBox(height: 16),
                  Text('Running diagnostics...'),
                ],
              ),
            )
          : RefreshIndicator(
              onRefresh: _runDiagnostics,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // Summary Card
                  _buildSummaryCard(),
                  const SizedBox(height: 16),
                  // Results
                  ..._results.map((result) => _buildResultCard(result)),
                  const SizedBox(height: 16),
                  // Actions
                  _buildActionsSection(),
                ],
              ),
            ),
    );
  }

  Widget _buildSummaryCard() {
    final errors = _results.where((r) => r.status == DiagnosticStatus.error).length;
    final warnings = _results.where((r) => r.status == DiagnosticStatus.warning).length;
    final successes = _results.where((r) => r.status == DiagnosticStatus.success).length;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryTeal, AppColors.darkTeal],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryTeal.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Diagnostics Summary',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSummaryItem('$successes', 'Passed', Colors.greenAccent),
              _buildSummaryItem('$warnings', 'Warnings', Colors.orangeAccent),
              _buildSummaryItem('$errors', 'Errors', Colors.redAccent),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String value, String label, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: color),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.white70),
        ),
      ],
    );
  }

  Widget _buildResultCard(DiagnosticsResult result) {
    IconData icon;
    Color color;

    switch (result.status) {
      case DiagnosticStatus.success:
        icon = Icons.check_circle;
        color = AppColors.success;
        break;
      case DiagnosticStatus.warning:
        icon = Icons.warning;
        color = AppColors.warning;
        break;
      case DiagnosticStatus.error:
        icon = Icons.error;
        color = AppColors.error;
        break;
      case DiagnosticStatus.info:
        icon = Icons.info;
        color = Colors.blue;
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      result.category,
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      result.message,
                      style: TextStyle(fontSize: 13, color: color),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (result.details != null) ...[
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                result.details!,
                style: TextStyle(fontSize: 11, color: AppColors.textGrey, fontFamily: 'monospace'),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildActionsSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quick Actions',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          _buildActionRow(Icons.build, 'Run Flutter Analyze', 'dart analyze --fatal-infos'),
          _buildActionRow(Icons.format_paint, 'Check Formatting', 'dart format --set-exit-if-changed .'),
          _buildActionRow(Icons.science, 'Run Tests', 'flutter test --coverage'),
          _buildActionRow(Icons.android, 'Build APK', 'flutter build apk --release'),
          _buildActionRow(Icons.web, 'Build Web', 'flutter build web --release'),
        ],
      ),
    );
  }

  Widget _buildActionRow(IconData icon, String title, String command) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.primaryTeal),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                Text(
                  command,
                  style: TextStyle(fontSize: 11, color: AppColors.textGrey, fontFamily: 'monospace'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum DiagnosticStatus { success, warning, error, info }

class DiagnosticsResult {
  final String category;
  final DiagnosticStatus status;
  final String message;
  final String? details;

  DiagnosticsResult({
    required this.category,
    required this.status,
    required this.message,
    this.details,
  });
}
