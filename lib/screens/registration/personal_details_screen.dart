import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/theme.dart';
import '../../config/routes.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/custom_text_field.dart';
import '../../utils/validators.dart';

class PersonalDetailsScreen extends StatefulWidget {
  const PersonalDetailsScreen({super.key});

  @override
  State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  String _selectedGender = '';

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  void _handleNext() {
    if (_formKey.currentState!.validate()) {
      // Store data in provider or pass to next screen
      Navigator.pushNamed(context, AppRoutes.verification);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textDark),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Step 2 of 5'),
        titleTextStyle: TextStyle(fontSize: 14, color: AppColors.textGrey),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Progress Bar
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: 0.4,
                    backgroundColor: AppColors.borderGrey,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryTeal),
                    minHeight: 8,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Personal Details',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Tell us about yourself',
                  style: TextStyle(fontSize: 14, color: AppColors.textGrey),
                ),
                const SizedBox(height: 24),
                // Name Row
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        labelText: 'First Name',
                        hintText: 'First name',
                        controller: _firstNameController,
                        validator: Validators.name,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CustomTextField(
                        labelText: 'Last Name',
                        hintText: 'Last name',
                        controller: _lastNameController,
                        validator: Validators.name,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Age
                CustomTextField(
                  labelText: 'Age',
                  hintText: 'Enter your age',
                  prefixIcon: Icons.cake_outlined,
                  controller: _ageController,
                  validator: Validators.age,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                // Weight & Height
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        labelText: 'Weight (kg)',
                        hintText: 'Weight',
                        prefixIcon: Icons.monitor_weight_outlined,
                        controller: _weightController,
                        validator: Validators.weight,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CustomTextField(
                        labelText: 'Height (cm)',
                        hintText: 'Height',
                        prefixIcon: Icons.height,
                        controller: _heightController,
                        validator: Validators.height,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Gender
                const Text(
                  'Gender',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildGenderOption('Male', Icons.male),
                    const SizedBox(width: 12),
                    _buildGenderOption('Female', Icons.female),
                    const SizedBox(width: 12),
                    _buildGenderOption('Other', Icons.transgender),
                  ],
                ),
                const SizedBox(height: 32),
                // Next Button
                CustomButton(
                  text: 'Next',
                  onPressed: _handleNext,
                  icon: Icons.arrow_forward,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGenderOption(String gender, IconData icon) {
    final isSelected = _selectedGender == gender;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedGender = gender),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryTeal : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppColors.primaryTeal : AppColors.borderGrey,
              width: 1.5,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.white : AppColors.textGrey,
                size: 28,
              ),
              const SizedBox(height: 4),
              Text(
                gender,
                style: TextStyle(
                  color: isSelected ? Colors.white : AppColors.textDark,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
