# CLOUDINARY SETUP GUIDE — Homigo Care

## Step-by-Step Cloudinary Configuration

---

## Step 1: Create Cloudinary Account

1. Go to https://cloudinary.com
2. Click **"Sign Up For Free"**
3. Fill in:
   - Company/Account Name: `homigo-care`
   - Email: your-email@example.com
   - Password: (strong password)
4. Select plan: **Free** (for development)
5. Verify email address

---

## Step 2: Access Dashboard

1. After login, you'll see the **Media Library** dashboard
2. Note your **Cloud Name** (shown in URL and settings)
3. Go to **Settings** (gear icon) > **Upload**

---

## Step 3: Get API Credentials

### Location: Settings > API Keys

| Credential | Where to Find | Example |
|------------|---------------|---------|
| Cloud Name | Dashboard URL or Settings > API | `dxxxxxxxxx` |
| API Key | Settings > API Keys | `123456789012345` |
| API Secret | Settings > API Keys (click reveal) | `xxxxxxxxxxxxxxxxxxxxxxxx` |

### Copy and Save These
```
Cloud Name: your_cloud_name
API Key: your_api_key
API Secret: your_api_secret
```

---

## Step 4: Create Upload Preset

### For Unsigned Uploads (Recommended for Flutter)

1. Go to **Settings** > **Upload**
2. Scroll to **"Upload presets"** section
3. Click **"Add upload preset"**
4. Configure:
   - **Preset name:** `homigo_care_unsigned`
   - **Signing mode:** `Unsigned`
   - **Folder:** `homigo-care`
   - **Unique filename:** `Enabled`
   - **Overwrite:** `Disabled`

5. Set **Allowed formats:**
   - `jpg, jpeg, png, webp, gif` (images)
   - `pdf, doc, docx` (documents)
   - `mp4` (videos - for splash)

6. Set **Transformations:**
   - Quality: `auto:good`
   - Format: `auto`
   - Max image size: `10MB`
   - Max video size: `50MB`

7. Click **"Save"**

---

## Step 5: Create Folder Structure

### In Media Library, create folders:

```
homigo-care/
├── profiles/           # User profile images
├── cnic/              # CNIC front/back images
├── doctors/           # Doctor profile images
├── banners/           # Banner/slider images
├── splash/            # Splash screen assets
├── notifications/     # Notification images
├── lab/               # Lab images
├── pharmacy/          # Pharmacy images
├── documents/         # PDF/medical documents
└── logos/             # App logos
```

### How to Create Folders
1. Go to **Media Library**
2. Click **"New folder"**
3. Enter folder name
4. Repeat for each subfolder

---

## Step 6: Configure Upload Settings

### Upload Settings (Settings > Upload)

#### Allowed Formats
```
Image: jpg, jpeg, png, webp, gif, bmp, tiff
Document: pdf, doc, docx, txt
Video: mp4, mov, avi
```

#### Upload Handling
- **Auto-organize:** Enabled
- **Unique filenames:** Enabled
- **Overwrite:** Disabled
- **Resource type auto-detection:** Enabled

#### Folders
- **Default folder:** `homigo-care`
- **Allow folder creation:** Yes

---

## Step 7: Configure Upload Presets for Different Use Cases

### Profile Images Preset
```
Preset name: homigo_care_profile
Folder: homigo-care/profiles
Transformations:
  - Resize: 400x400 (face crop)
  - Quality: auto:good
  - Format: auto
Max size: 5MB
Allowed: jpg, jpeg, png, webp
```

### CNIC Images Preset
```
Preset name: homigo_care_cnic
Folder: homigo-care/cnic
Transformations:
  - Quality: auto:best
  - Format: auto
Max size: 10MB
Allowed: jpg, jpeg, png, webp
```

### Banner Images Preset
```
Preset name: homigo_care_banner
Folder: homigo-care/banners
Transformations:
  - Resize: 1200x600
  - Quality: auto:good
  - Format: auto
Max size: 5MB
Allowed: jpg, jpeg, png, webp
```

### Document Preset
```
Preset name: homigo_care_document
Folder: homigo-care/documents
Max size: 10MB
Allowed: pdf, doc, docx
```

---

## Step 8: Flutter Integration

### Add to pubspec.yaml
```yaml
dependencies:
  cloudinary: ^1.2.0
  cloudinary_flutter: ^1.0.0
  # OR
  cloudinary_public: ^0.13.0+4
```

### Run flutter pub get
```bash
flutter pub get
```

---

## Step 9: Create Cloudinary Service

### lib/services/cloudinary_service.dart

```dart
import 'package:cloudinary/cloudinary.dart';

class CloudinaryService {
  // Use your credentials from Cloudinary Dashboard
  static const String cloudName = 'YOUR_CLOUD_NAME';
  static const String uploadPreset = 'homigo_care_unsigned';

  final Cloudinary cloudinary = Cloudinary.signed(
    cloudName: cloudName,
    apiKey: 'YOUR_API_KEY',
    apiSecret: 'YOUR_API_SECRET',
  );

  // OR for unsigned uploads
  final Cloudinary unsignedCloudinary = Cloudinary.unsigned(
    cloudName: cloudName,
    uploadPreset: uploadPreset,
  );

  // Upload Image
  Future<CloudinaryResponse> uploadImage({
    required String filePath,
    String folder = 'homigo-care/profiles',
  }) async {
    try {
      final response = await cloudinary.uploadFile(
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

  // Upload Document
  Future<CloudinaryResponse> uploadDocument({
    required String filePath,
    String folder = 'homigo-care/documents',
  }) async {
    try {
      final response = await cloudinary.uploadFile(
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
      final response = await cloudinary.uploadFile(
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

  // Delete Image
  Future<void> deleteFile(String publicId) async {
    try {
      await cloudinary.deleteFile(publicId);
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
    return cloudinary.imageUri(
      publicId,
      transformation: Transformation()
        ..width(width)
        ..height(height)
        ..quality(quality),
    );
  }
}
```

---

## Step 10: Environment Variables

### .env File
```
CLOUDINARY_CLOUD_NAME=your_cloud_name
CLOUDINARY_API_KEY=your_api_key
CLOUDINARY_API_SECRET=your_api_secret
CLOUDINARY_UPLOAD_PRESET=homigo_care_unsigned
```

### Load in Dart
```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

// In main.dart
await dotenv.load();

// Usage
final cloudName = dotenv.env['CLOUDINARY_CLOUD_NAME'];
```

---

## Step 11: Test Upload

### Test Code
```dart
import 'package:cloudinary/cloudinary.dart';

void testCloudinary() async {
  final cloudinary = Cloudinary.signed(
    cloudName: 'YOUR_CLOUD_NAME',
    apiKey: 'YOUR_API_KEY',
    apiSecret: 'YOUR_API_SECRET',
  );

  // Test upload
  final response = await cloudinary.uploadFile(
    CloudinaryFile.fromFile(
      '/path/to/test/image.jpg',
      folder: 'homigo-care/test',
      resourceType: CloudinaryResourceType.image,
    ),
  );

  print('Upload URL: ${response.secureUrl}');
  print('Public ID: ${response.publicId}');
}
```

---

## Step 12: Dashboard URLs

| Service | URL |
|---------|-----|
| Media Library | https://cloudinary.com/console/media_library |
| Settings | https://cloudinary.com/console/settings |
| Upload Settings | https://cloudinary.com/console/settings/upload |
| API Keys | https://cloudinary.com/console/settings/api-keys |
| Documentation | https://cloudinary.com/documentation |

---

## Cloudinary Pricing (Free Tier)

### Free Plan Includes
- **Storage:** 25 GB
- **Bandwidth:** 25 GB/month
- **Transformations:** 25,000/month
- **Uploads:** 25,000 images/month
- **Managed Fonts:** 20 fonts

### Notes
- Free tier is sufficient for development
- Upgrade for production if needed
- Monitor usage in dashboard

---

## Troubleshooting

### Common Issues

1. **"Upload preset not found"**
   - Verify preset name is correct
   - Ensure preset is set to "Unsigned"
   - Check preset is active

2. **"Invalid API key"**
   - Regenerate API key in settings
   - Ensure correct cloud name
   - Check for typos

3. **"File too large"**
   - Check file size limits
   - Compress images before upload
   - Increase limits in upload preset

4. **"Folder not found"**
   - Create folder in Media Library
   - Ensure folder path is correct
   - Check folder permissions

5. **"CORS error"**
   - Add your domain to allowed origins
   - Use signed uploads
   - Check upload preset settings

---

## Security Notes

1. **Never expose API Secret in client code**
   - Use signed uploads for production
   - Keep secrets on server
   - Use environment variables

2. **Use Upload Presets**
   - Unsigned presets for development
   - Signed presets for production
   - Restrict folder access

3. **Enable Auto-Delete**
   - Delete unused files
   - Monitor storage usage
   - Set up cleanup policies

---

## Next Steps

After Cloudinary setup:
1. ✅ Test file upload
2. ✅ Test image transformations
3. ✅ Configure Firebase (see FIREBASE_SETUP.md)
4. ✅ Start building Flutter app
