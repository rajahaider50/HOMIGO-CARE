class UserModel {
  final String uid;
  final String email;
  final String phoneNumber;
  final String role;
  final String firstName;
  final String lastName;
  final String fullName;
  final int age;
  final double weight;
  final double height;
  final String gender;
  final String profileImage;
  final String cnicFront;
  final String cnicBack;
  final String allergies;
  final String illness;
  final bool isVerified;
  final bool isActive;
  final bool isAdmin;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserModel({
    required this.uid,
    required this.email,
    this.phoneNumber = '',
    required this.role,
    this.firstName = '',
    this.lastName = '',
    this.fullName = '',
    this.age = 0,
    this.weight = 0,
    this.height = 0,
    this.gender = '',
    this.profileImage = '',
    this.cnicFront = '',
    this.cnicBack = '',
    this.allergies = '',
    this.illness = '',
    this.isVerified = false,
    this.isActive = true,
    this.isAdmin = false,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromMap(Map<dynamic, dynamic> map, String uid) {
    return UserModel(
      uid: uid,
      email: map['email']?.toString() ?? '',
      phoneNumber: map['phoneNumber']?.toString() ?? '',
      role: map['role']?.toString() ?? '',
      firstName: map['firstName']?.toString() ?? '',
      lastName: map['lastName']?.toString() ?? '',
      fullName: map['fullName']?.toString() ?? '',
      age: map['age'] ?? 0,
      weight: (map['weight'] ?? 0).toDouble(),
      height: (map['height'] ?? 0).toDouble(),
      gender: map['gender']?.toString() ?? '',
      profileImage: map['profileImage']?.toString() ?? '',
      cnicFront: map['cnicFront']?.toString() ?? '',
      cnicBack: map['cnicBack']?.toString() ?? '',
      allergies: map['allergies']?.toString() ?? '',
      illness: map['illness']?.toString() ?? '',
      isVerified: map['isVerified'] ?? false,
      isActive: map['isActive'] ?? true,
      isAdmin: map['isAdmin'] ?? false,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'])
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'phoneNumber': phoneNumber,
      'role': role,
      'firstName': firstName,
      'lastName': lastName,
      'fullName': fullName,
      'age': age,
      'weight': weight,
      'height': height,
      'gender': gender,
      'profileImage': profileImage,
      'cnicFront': cnicFront,
      'cnicBack': cnicBack,
      'allergies': allergies,
      'illness': illness,
      'isVerified': isVerified,
      'isActive': isActive,
      'isAdmin': isAdmin,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': DateTime.now().millisecondsSinceEpoch,
    };
  }

  UserModel copyWith({
    String? uid,
    String? email,
    String? phoneNumber,
    String? role,
    String? firstName,
    String? lastName,
    String? fullName,
    int? age,
    double? weight,
    double? height,
    String? gender,
    String? profileImage,
    String? cnicFront,
    String? cnicBack,
    String? allergies,
    String? illness,
    bool? isVerified,
    bool? isActive,
    bool? isAdmin,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      fullName: fullName ?? this.fullName,
      age: age ?? this.age,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      gender: gender ?? this.gender,
      profileImage: profileImage ?? this.profileImage,
      cnicFront: cnicFront ?? this.cnicFront,
      cnicBack: cnicBack ?? this.cnicBack,
      allergies: allergies ?? this.allergies,
      illness: illness ?? this.illness,
      isVerified: isVerified ?? this.isVerified,
      isActive: isActive ?? this.isActive,
      isAdmin: isAdmin ?? this.isAdmin,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
  }
}
