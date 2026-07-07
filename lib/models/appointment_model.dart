class AppointmentModel {
  final String appointmentId;
  final String patientId;
  final String doctorId;
  final String date;
  final String time;
  final String status;
  final String type;
  final String notes;
  final DateTime? createdAt;

  AppointmentModel({
    required this.appointmentId,
    required this.patientId,
    required this.doctorId,
    required this.date,
    required this.time,
    this.status = 'pending',
    this.type = '',
    this.notes = '',
    this.createdAt,
  });

  factory AppointmentModel.fromMap(Map<dynamic, dynamic> map, String id) {
    return AppointmentModel(
      appointmentId: id,
      patientId: map['patientId']?.toString() ?? '',
      doctorId: map['doctorId']?.toString() ?? '',
      date: map['date']?.toString() ?? '',
      time: map['time']?.toString() ?? '',
      status: map['status']?.toString() ?? 'pending',
      type: map['type']?.toString() ?? '',
      notes: map['notes']?.toString() ?? '',
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'patientId': patientId,
      'doctorId': doctorId,
      'date': date,
      'time': time,
      'status': status,
      'type': type,
      'notes': notes,
      'createdAt': createdAt?.millisecondsSinceEpoch ?? DateTime.now().millisecondsSinceEpoch,
    };
  }

  AppointmentModel copyWith({
    String? appointmentId,
    String? patientId,
    String? doctorId,
    String? date,
    String? time,
    String? status,
    String? type,
    String? notes,
  }) {
    return AppointmentModel(
      appointmentId: appointmentId ?? this.appointmentId,
      patientId: patientId ?? this.patientId,
      doctorId: doctorId ?? this.doctorId,
      date: date ?? this.date,
      time: time ?? this.time,
      status: status ?? this.status,
      type: type ?? this.type,
      notes: notes ?? this.notes,
      createdAt: createdAt,
    );
  }
}
