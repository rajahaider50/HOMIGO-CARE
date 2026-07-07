import 'package:flutter/material.dart';
import '../../config/theme.dart';
import '../../services/database_service.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  final DatabaseService _dbService = DatabaseService();
  Map<String, int> _stats = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  void _loadStats() async {
    final stats = await _dbService.getStats();
    setState(() {
      _stats = stats;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadStats,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Overview',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  // Stats Grid
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.5,
                    children: [
                      _buildStatCard('Total Users', _stats['totalUsers'] ?? 0, Icons.people, AppColors.primaryTeal),
                      _buildStatCard('Patients', _stats['totalPatients'] ?? 0, Icons.person, AppColors.success),
                      _buildStatCard('Doctors', _stats['totalDoctors'] ?? 0, Icons.medical_services, Colors.blue),
                      _buildStatCard('Appointments', _stats['totalAppointments'] ?? 0, Icons.calendar_today, AppColors.accentOrange),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Quick Actions',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _buildActionCard(
                    icon: Icons.people_outline,
                    title: 'User Management',
                    subtitle: 'View, approve, or reject users',
                    onTap: () {},
                  ),
                  const SizedBox(height: 12),
                  _buildActionCard(
                    icon: Icons.medical_services_outlined,
                    title: 'Doctor Management',
                    subtitle: 'Manage doctor profiles and approvals',
                    onTap: () {},
                  ),
                  const SizedBox(height: 12),
                  _buildActionCard(
                    icon: Icons.verified_outlined,
                    title: 'Document Verification',
                    subtitle: 'Verify user documents (CNIC)',
                    onTap: () {},
                  ),
                  const SizedBox(height: 12),
                  _buildActionCard(
                    icon: Icons.slow_motion_video_outlined,
                    title: 'Splash Management',
                    subtitle: 'Configure app splash screen',
                    onTap: () {},
                  ),
                  const SizedBox(height: 12),
                  _buildActionCard(
                    icon: Icons.notifications_outlined,
                    title: 'Notifications',
                    subtitle: 'Send notifications to users',
                    onTap: () {},
                  ),
                  const SizedBox(height: 12),
                  _buildActionCard(
                    icon: Icons.settings_outlined,
                    title: 'App Settings',
                    subtitle: 'Configure app settings',
                    onTap: () {},
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildStatCard(String title, int value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderGrey),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 28),
          const Spacer(),
          Text(
            value.toString(),
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: TextStyle(fontSize: 12, color: AppColors.textGrey),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.borderGrey),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primaryTeal.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppColors.primaryTeal),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: TextStyle(fontSize: 12, color: AppColors.textGrey)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.textGrey),
          ],
        ),
      ),
    );
  }
}
