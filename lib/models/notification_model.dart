class NotificationModel {
  final String notificationId;
  final String title;
  final String body;
  final String type;
  final String targetRole;
  final bool isRead;
  final DateTime? createdAt;

  NotificationModel({
    required this.notificationId,
    required this.title,
    required this.body,
    this.type = '',
    this.targetRole = 'all',
    this.isRead = false,
    this.createdAt,
  });

  factory NotificationModel.fromMap(Map<dynamic, dynamic> map, String id) {
    return NotificationModel(
      notificationId: id,
      title: map['title']?.toString() ?? '',
      body: map['body']?.toString() ?? '',
      type: map['type']?.toString() ?? '',
      targetRole: map['targetRole']?.toString() ?? 'all',
      isRead: map['isRead'] ?? false,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
      'type': type,
      'targetRole': targetRole,
      'isRead': isRead,
      'createdAt': createdAt?.millisecondsSinceEpoch ?? DateTime.now().millisecondsSinceEpoch,
    };
  }

  NotificationModel copyWith({
    String? notificationId,
    String? title,
    String? body,
    String? type,
    String? targetRole,
    bool? isRead,
  }) {
    return NotificationModel(
      notificationId: notificationId ?? this.notificationId,
      title: title ?? this.title,
      body: body ?? this.body,
      type: type ?? this.type,
      targetRole: targetRole ?? this.targetRole,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt,
    );
  }
}
