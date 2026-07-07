import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../config/constants.dart';

class CloudinaryService {
  static final CloudinaryService _instance = CloudinaryService._internal();
  factory CloudinaryService() => _instance;
  CloudinaryService._internal();

  Future<Map<String, dynamic>?> uploadImage({
    required String filePath,
    String folder = 'homigo-care/profiles',
  }) async {
    try {
      final file = File(filePath);
      if (!await file.exists()) return null;

      final bytes = await file.readAsBytes();
      final fileName = '${DateTime.now().millisecondsSinceEpoch}_${folder.replaceAll('/', '_')}';

      final uri = Uri.parse(
        'https://api.cloudinary.com/v1_1/${AppConstants.cloudinaryCloudName}/image/upload',
      );

      final request = http.MultipartRequest('POST', uri)
        ..fields['upload_preset'] = AppConstants.cloudinaryUploadPreset
        ..fields['folder'] = folder
        ..fields['public_id'] = fileName
        ..files.add(http.MultipartFile.fromBytes(
          'file',
          bytes,
          filename: fileName,
        ));

      final response = await request.send();
      final responseData = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        return json.decode(responseData);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>?> uploadDocument({
    required String filePath,
    String folder = 'homigo-care/documents',
  }) async {
    try {
      final file = File(filePath);
      if (!await file.exists()) return null;

      final bytes = await file.readAsBytes();
      final fileName = '${DateTime.now().millisecondsSinceEpoch}_${folder.replaceAll('/', '_')}';

      final uri = Uri.parse(
        'https://api.cloudinary.com/v1_1/${AppConstants.cloudinaryCloudName}/raw/upload',
      );

      final request = http.MultipartRequest('POST', uri)
        ..fields['upload_preset'] = AppConstants.cloudinaryUploadPreset
        ..fields['folder'] = folder
        ..fields['public_id'] = fileName
        ..files.add(http.MultipartFile.fromBytes(
          'file',
          bytes,
          filename: fileName,
        ));

      final response = await request.send();
      final responseData = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        return json.decode(responseData);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  String getOptimizedUrl(String publicId, {int? width, int? height}) {
    String transformations = 'f_auto,q_auto';
    if (width != null) transformations += ',w_$width';
    if (height != null) transformations += ',h_$height';
    return 'https://res.cloudinary.com/${AppConstants.cloudinaryCloudName}/image/upload/$transformations/$publicId';
  }
}
