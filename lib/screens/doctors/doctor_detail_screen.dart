import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/theme.dart';
import '../../config/routes.dart';
import '../../providers/doctor_provider.dart';
import '../../widgets/common/custom_button.dart';

class DoctorDetailScreen extends StatefulWidget {
  final String doctorId;
  const DoctorDetailScreen({super.key, required this.doctorId});

  @override
  State<DoctorDetailScreen> createState() => _DoctorDetailScreenState();
}

class _DoctorDetailScreenState extends State<DoctorDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DoctorProvider>().loadDoctor(widget.doctorId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Consumer<DoctorProvider>(
        builder: (context, doctorProvider, child) {
          final doctor = doctorProvider.selectedDoctor;

          if (doctorProvider.isLoading || doctor == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Header
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [AppColors.primaryTeal, AppColors.darkTeal],
                          ),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primaryTeal.withOpacity(0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.person, size: 60, color: Colors.white),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        doctor.specialization,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.star, size: 18, color: AppColors.warning),
                          const SizedBox(width: 4),
                          Text(
                            doctor.rating.toString(),
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${doctor.experience} years exp.',
                            style: TextStyle(fontSize: 14, color: AppColors.textGrey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Info Cards
                Row(
                  children: [
                    _buildInfoCard(Icons.attach_money, 'Fee', '\$${doctor.consultationFee}'),
                    const SizedBox(width: 12),
                    _buildInfoCard(Icons.location_on, 'Location', doctor.clinicAddress.isNotEmpty ? 'Available' : 'Not set'),
                    const SizedBox(width: 12),
                    _buildInfoCard(Icons.schedule, 'Schedule', 'Mon-Fri'),
                  ],
                ),
                const SizedBox(height: 24),
                // About
                const Text(
                  'About Doctor',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Text(
                  doctor.description.isNotEmpty
                      ? doctor.description
                      : 'No description available.',
                  style: TextStyle(fontSize: 14, color: AppColors.textGrey, height: 1.5),
                ),
                const SizedBox(height: 24),
                // Qualifications
                if (doctor.qualifications.isNotEmpty) ...[
                  const Text(
                    'Qualifications',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  ...doctor.qualifications.map((q) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        const Icon(Icons.check_circle, size: 18, color: AppColors.success),
                        const SizedBox(width: 8),
                        Text(q, style: const TextStyle(fontSize: 14)),
                      ],
                    ),
                  )),
                  const SizedBox(height: 16),
                ],
                // Book Button
                CustomButton(
                  text: 'Book Appointment',
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.booking,
                      arguments: {'doctorId': doctor.uid},
                    );
                  },
                  icon: Icons.calendar_today,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.primaryTeal.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.primaryTeal.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primaryTeal, size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(fontSize: 11, color: AppColors.textGrey),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
