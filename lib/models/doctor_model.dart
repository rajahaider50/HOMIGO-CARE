class DoctorModel {
  final String uid;
  final String specialization;
  final double rating;
  final double consultationFee;
  final String description;
  final List<String> qualifications;
  final int experience;
  final String clinicAddress;
  final bool isApproved;
  final Map<String, List<String>> availability;

  DoctorModel({
    required this.uid,
    this.specialization = '',
    this.rating = 0,
    this.consultationFee = 0,
    this.description = '',
    this.qualifications = const [],
    this.experience = 0,
    this.clinicAddress = '',
    this.isApproved = false,
    this.availability = const {},
  });

  factory DoctorModel.fromMap(Map<dynamic, dynamic> map, String uid) {
    List<String> quals = [];
    if (map['qualifications'] != null) {
      if (map['qualifications'] is List) {
        quals = List<String>.from(map['qualifications'].map((e) => e.toString()));
      }
    }

    Map<String, List<String>> avail = {};
    if (map['availability'] != null && map['availability'] is Map) {
      map['availability'].forEach((key, value) {
        if (value is List) {
          avail[key.toString()] = List<String>.from(value.map((e) => e.toString()));
        }
      });
    }

    return DoctorModel(
      uid: uid,
      specialization: map['specialization']?.toString() ?? '',
      rating: (map['rating'] ?? 0).toDouble(),
      consultationFee: (map['consultationFee'] ?? 0).toDouble(),
      description: map['description']?.toString() ?? '',
      qualifications: quals,
      experience: map['experience'] ?? 0,
      clinicAddress: map['clinicAddress']?.toString() ?? '',
      isApproved: map['isApproved'] ?? false,
      availability: avail,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'specialization': specialization,
      'rating': rating,
      'consultationFee': consultationFee,
      'description': description,
      'qualifications': qualifications,
      'experience': experience,
      'clinicAddress': clinicAddress,
      'isApproved': isApproved,
      'availability': availability,
    };
  }

  DoctorModel copyWith({
    String? uid,
    String? specialization,
    double? rating,
    double? consultationFee,
    String? description,
    List<String>? qualifications,
    int? experience,
    String? clinicAddress,
    bool? isApproved,
    Map<String, List<String>>? availability,
  }) {
    return DoctorModel(
      uid: uid ?? this.uid,
      specialization: specialization ?? this.specialization,
      rating: rating ?? this.rating,
      consultationFee: consultationFee ?? this.consultationFee,
      description: description ?? this.description,
      qualifications: qualifications ?? this.qualifications,
      experience: experience ?? this.experience,
      clinicAddress: clinicAddress ?? this.clinicAddress,
      isApproved: isApproved ?? this.isApproved,
      availability: availability ?? this.availability,
    );
  }
}
