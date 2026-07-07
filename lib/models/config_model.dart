class BannerModel {
  final String bannerId;
  final String imageUrl;
  final String title;
  final String link;
  final bool isActive;
  final int order;

  BannerModel({
    required this.bannerId,
    required this.imageUrl,
    this.title = '',
    this.link = '',
    this.isActive = true,
    this.order = 0,
  });

  factory BannerModel.fromMap(Map<dynamic, dynamic> map, String id) {
    return BannerModel(
      bannerId: id,
      imageUrl: map['imageUrl']?.toString() ?? '',
      title: map['title']?.toString() ?? '',
      link: map['link']?.toString() ?? '',
      isActive: map['isActive'] ?? true,
      order: map['order'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'title': title,
      'link': link,
      'isActive': isActive,
      'order': order,
    };
  }
}

class SplashConfig {
  final int type;
  final bool isEnabled;
  final String videoUrl;
  final String imageUrl;
  final String htmlContent;
  final String animatedText;

  SplashConfig({
    this.type = 1,
    this.isEnabled = true,
    this.videoUrl = '',
    this.imageUrl = '',
    this.htmlContent = '',
    this.animatedText = '',
  });

  factory SplashConfig.fromMap(Map<dynamic, dynamic> map) {
    return SplashConfig(
      type: map['type'] ?? 1,
      isEnabled: map['isEnabled'] ?? true,
      videoUrl: map['videoUrl']?.toString() ?? '',
      imageUrl: map['imageUrl']?.toString() ?? '',
      htmlContent: map['htmlContent']?.toString() ?? '',
      animatedText: map['animatedText']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'isEnabled': isEnabled,
      'videoUrl': videoUrl,
      'imageUrl': imageUrl,
      'htmlContent': htmlContent,
      'animatedText': animatedText,
    };
  }
}

class AppSettings {
  final String appName;
  final String logo;
  final String primaryColor;
  final String secondaryColor;
  final String supportEmail;
  final String supportPhone;
  final String privacyPolicy;
  final String termsOfService;
  final String about;
  final bool maintenanceMode;

  AppSettings({
    this.appName = 'Homigo Care',
    this.logo = '',
    this.primaryColor = '#1AA69D',
    this.secondaryColor = '#F2884B',
    this.supportEmail = '',
    this.supportPhone = '',
    this.privacyPolicy = '',
    this.termsOfService = '',
    this.about = '',
    this.maintenanceMode = false,
  });

  factory AppSettings.fromMap(Map<dynamic, dynamic> map) {
    return AppSettings(
      appName: map['appName']?.toString() ?? 'Homigo Care',
      logo: map['logo']?.toString() ?? '',
      primaryColor: map['primaryColor']?.toString() ?? '#1AA69D',
      secondaryColor: map['secondaryColor']?.toString() ?? '#F2884B',
      supportEmail: map['supportEmail']?.toString() ?? '',
      supportPhone: map['supportPhone']?.toString() ?? '',
      privacyPolicy: map['privacyPolicy']?.toString() ?? '',
      termsOfService: map['termsOfService']?.toString() ?? '',
      about: map['about']?.toString() ?? '',
      maintenanceMode: map['maintenanceMode'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'appName': appName,
      'logo': logo,
      'primaryColor': primaryColor,
      'secondaryColor': secondaryColor,
      'supportEmail': supportEmail,
      'supportPhone': supportPhone,
      'privacyPolicy': privacyPolicy,
      'termsOfService': termsOfService,
      'about': about,
      'maintenanceMode': maintenanceMode,
    };
  }
}
