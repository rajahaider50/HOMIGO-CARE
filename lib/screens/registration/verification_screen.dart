import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../config/theme.dart';
import '../../config/routes.dart';
import '../../widgets/common/custom_button.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  File? _cnicFront;
  File? _cnicBack;
  File? _profileImage;
  final _picker = ImagePicker();

  Future<void> _pickImage(String type) async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 85,
    );

    if (image != null) {
      setState(() {
        switch (type) {
          case 'cnic_front':
            _cnicFront = File(image.path);
            break;
          case 'cnic_back':
            _cnicBack = File(image.path);
            break;
          case 'profile':
            _profileImage = File(image.path);
            break;
        }
      });
    }
  }

  void _handleNext() {
    if (_cnicFront == null || _cnicBack == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please upload both CNIC images'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }
    Navigator.pushNamed(context, AppRoutes.medicalInfo);
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
        title: const Text('Step 3 of 5'),
        titleTextStyle: TextStyle(fontSize: 14, color: AppColors.textGrey),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress Bar
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: 0.6,
                  backgroundColor: AppColors.borderGrey,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryTeal),
                  minHeight: 8,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Verification',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Upload your documents for verification',
                style: TextStyle(fontSize: 14, color: AppColors.textGrey),
              ),
              const SizedBox(height: 32),
              // Profile Image
              Center(
                child: GestureDetector(
                  onTap: () => _pickImage('profile'),
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryTeal.withOpacity(0.1),
                      border: Border.all(
                        color: AppColors.primaryTeal,
                        width: 2,
                      ),
                    ),
                    child: _profileImage != null
                        ? ClipOval(
                            child: Image.file(
                              _profileImage!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.camera_alt, size: 32, color: AppColors.primaryTeal),
                              SizedBox(height: 4),
                              Text('Upload\nPhoto', textAlign: TextAlign.center, style: TextStyle(fontSize: 11)),
                            ],
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              // CNIC Front
              _buildUploadCard(
                title: 'CNIC Front',
                subtitle: 'Upload front side of your CNIC',
                image: _cnicFront,
                onTap: () => _pickImage('cnic_front'),
              ),
              const SizedBox(height: 16),
              // CNIC Back
              _buildUploadCard(
                title: 'CNIC Back',
                subtitle: 'Upload back side of your CNIC',
                image: _cnicBack,
                onTap: () => _pickImage('cnic_back'),
              ),
              const SizedBox(height: 32),
              CustomButton(
                text: 'Next',
                onPressed: _handleNext,
                icon: Icons.arrow_forward,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUploadCard({
    required String title,
    required String subtitle,
    File? image,
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
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: image != null
                    ? AppColors.success.withOpacity(0.1)
                    : AppColors.primaryTeal.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(image, fit: BoxFit.cover),
                    )
                  : const Icon(Icons.upload_file, color: AppColors.primaryTeal),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12, color: AppColors.textGrey),
                  ),
                ],
              ),
            ),
            Icon(
              image != null ? Icons.check_circle : Icons.add_circle_outline,
              color: image != null ? AppColors.success : AppColors.primaryTeal,
            ),
          ],
        ),
      ),
    );
  }
}
