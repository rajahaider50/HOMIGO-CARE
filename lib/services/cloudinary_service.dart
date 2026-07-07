import 'dart:io';
import 'package:cloudinary/cloudinary.dart';
import '../config/constants.dart';

class CloudinaryService {
  late final Cloudinary _cloudinary;

  static final CloudinaryService _instance = CloudinaryService._internal();
  factory CloudinaryService() => _instance;

  CloudinaryService._internal() {
    _cloudinary = Cloudinary.signed(
      cloudName: AppConstants.cloudinaryCloudName,
      apiKey: AppConstants.cloudinaryApiKey,
      apiSecret: '',
    );
  }

  // Upload Image
  Future<CloudinaryResponse> uploadImage({
    required String filePath,
    String folder = 'homigo-care/profiles',
  }) async {
    try {
      final response = await _cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          filePath,
          folder: folder,
          resourceType: CloudinaryResourceType.image,
        ),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }

  // Upload from bytes
  Future<CloudinaryResponse> uploadImageBytes({
    required List<int> bytes,
    required String fileName,
    String folder = 'homigo-care/profiles',
  }) async {
    try {
      final response = await _cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          '',
          folder: folder,
          resourceType: CloudinaryResourceType.image,
          bytes: bytes,
          publicId: fileName,
        ),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }

  // Upload Document
  Future<CloudinaryResponse> uploadDocument({
    required String filePath,
    String folder = 'homigo-care/documents',
  }) async {
    try {
      final response = await _cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          filePath,
          folder: folder,
          resourceType: CloudinaryResourceType.auto,
        ),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to upload document: $e');
    }
  }

  // Upload Video
  Future<CloudinaryResponse> uploadVideo({
    required String filePath,
    String folder = 'homigo-care/splash',
  }) async {
    try {
      final response = await _cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          filePath,
          folder: folder,
          resourceType: CloudinaryResourceType.video,
        ),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to upload video: $e');
    }
  }

  // Delete File
  Future<void> deleteFile(String publicId) async {
    try {
      await _cloudinary.deleteFile(publicId);
    } catch (e) {
      throw Exception('Failed to delete file: $e');
    }
  }

  // Get optimized URL
  String getOptimizedUrl(String publicId, {
    int? width,
    int? height,
    String quality = 'auto:good',
  }) {
    return _cloudinary.imageUri(
      publicId,
      transformation: Transformation()
        ..width(width)
        ..height(height)
        ..quality(quality),
    );
  }
}
