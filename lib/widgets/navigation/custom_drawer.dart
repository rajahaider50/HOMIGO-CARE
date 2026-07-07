import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/theme.dart';
import '../../config/routes.dart';
import '../../providers/auth_provider.dart';
import '../common/custom_card.dart';

class CustomDrawer extends StatelessWidget {
  final String userName;
  final String userRole;
  final String profileImage;

  const CustomDrawer({
    super.key,
    this.userName = '',
    this.userRole = '',
    this.profileImage = '',
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            // Profile Header
            Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  ProfileImageWidget(
                    imageUrl: profileImage,
                    size: 80,
                    initials: userName.isNotEmpty ? userName[0].toUpperCase() : 'U',
                  ),
                  const SizedBox(height: 12),
                  Text(
                    userName.isNotEmpty ? userName : 'Guest User',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primaryTeal.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      userRole.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryTeal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            // Menu Items
            _buildMenuItem(
              context: context,
              icon: Icons.home_outlined,
              title: 'Home',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, AppRoutes.home);
              },
            ),
            _buildMenuItem(
              context: context,
              icon: Icons.person_outline,
              title: 'Profile',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.profile);
              },
            ),
            _buildMenuItem(
              context: context,
              icon: Icons.calendar_today_outlined,
              title: 'My Bookings',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.appointments);
              },
            ),
            _buildMenuItem(
              context: context,
              icon: Icons.medical_services_outlined,
              title: 'Doctors',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.doctorsList);
              },
            ),
            _buildMenuItem(
              context: context,
              icon: Icons.notifications_outlined,
              title: 'Notifications',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.notifications);
              },
            ),
            _buildMenuItem(
              context: context,
              icon: Icons.settings_outlined,
              title: 'Settings',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.settings);
              },
            ),
            _buildMenuItem(
              context: context,
              icon: Icons.info_outline,
              title: 'About',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.about);
              },
            ),
            const Spacer(),
            const Divider(),
            _buildMenuItem(
              context: context,
              icon: Icons.logout,
              title: 'Logout',
              color: AppColors.error,
              onTap: () {
                Navigator.pop(context);
                _showLogoutDialog(context);
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
  }) {
    return ListTile(
      leading: Icon(icon, color: color ?? AppColors.textDark, size: 24),
      title: Text(
        title,
        style: TextStyle(
          color: color ?? AppColors.textDark,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<AuthProvider>().signOut();
              Navigator.pushReplacementNamed(context, AppRoutes.login);
            },
            child: const Text('Logout', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }
}
