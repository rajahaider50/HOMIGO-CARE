import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/theme.dart';
import '../../config/constants.dart';
import '../../config/routes.dart';
import '../../providers/doctor_provider.dart';
import '../../widgets/common/custom_text_field.dart';

class DoctorsListScreen extends StatefulWidget {
  const DoctorsListScreen({super.key});

  @override
  State<DoctorsListScreen> createState() => _DoctorsListScreenState();
}

class _DoctorsListScreenState extends State<DoctorsListScreen> {
  final _searchController = TextEditingController();
  String _selectedSpecialization = '';

  @override
  void initState() {
    super.initState();
    context.read<DoctorProvider>().loadApprovedDoctors();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctors'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Search
          Padding(
            padding: const EdgeInsets.all(16),
            child: CustomTextField(
              labelText: '',
              hintText: 'Search doctors...',
              prefixIcon: Icons.search,
              controller: _searchController,
              onChanged: (value) {
                context.read<DoctorProvider>().setSearchQuery(value);
              },
            ),
          ),
          // Specialization Filter
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildFilterChip('All', ''),
                ...AppConstants.specializations.map((s) => _buildFilterChip(s, s)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Doctor List
          Expanded(
            child: Consumer<DoctorProvider>(
              builder: (context, doctorProvider, child) {
                final doctors = doctorProvider.filteredDoctors;

                if (doctorProvider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (doctors.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.medical_services, size: 80, color: AppColors.textGrey),
                        SizedBox(height: 16),
                        Text('No doctors found', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: doctors.length,
                  itemBuilder: (context, index) {
                    final doctor = doctors[index];
                    return _buildDoctorCard(doctor);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
    final isSelected = _selectedSpecialization == value;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          setState(() => _selectedSpecialization = value);
          context.read<DoctorProvider>().setSelectedSpecialization(value);
        },
        selectedColor: AppColors.primaryTeal,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : AppColors.textDark,
          fontSize: 12,
        ),
        checkmarkColor: Colors.white,
        side: BorderSide(
          color: isSelected ? AppColors.primaryTeal : AppColors.borderGrey,
        ),
      ),
    );
  }

  Widget _buildDoctorCard(dynamic doctor) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.doctorDetail,
          arguments: {'doctorId': doctor.uid},
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
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
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primaryTeal.withOpacity(0.1), AppColors.primaryTeal.withOpacity(0.05)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.person, size: 35, color: AppColors.primaryTeal),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctor.specialization,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Experience: ${doctor.experience} years',
                    style: TextStyle(fontSize: 13, color: AppColors.textGrey),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 14, color: AppColors.warning),
                      const SizedBox(width: 4),
                      Text(
                        doctor.rating.toString(),
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '\$${doctor.consultationFee}',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryTeal,
                        ),
                      ),
                    ],
                  ),
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
