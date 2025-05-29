import 'package:get/get.dart';

enum ServiceOrderStatus {
  pending, // 待分配服务人员
  assigned, // 已分配服务人员
  inProgress, // 服务进行中
  completed, // 已完成
  cancelled, // 已取消
  disputed, // 争议中
}

class ServiceOrder {
  final String id;
  final String requestId;
  final String userId;
  final String? providerId;
  final String title;
  final String description;
  final List<String> categories;
  final String location;
  final DateTime startDate;
  final DateTime endDate;
  final double budget;
  final ServiceOrderStatus status;
  final DateTime createdAt;
  final DateTime? assignedAt;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final String? cancellationReason;
  final List<String>? attachments;
  final List<ServiceOrderProgress>? progress;
  final Map<String, dynamic>? customFields;

  ServiceOrder({
    required this.id,
    required this.requestId,
    required this.userId,
    this.providerId,
    required this.title,
    required this.description,
    required this.categories,
    required this.location,
    required this.startDate,
    required this.endDate,
    required this.budget,
    required this.status,
    required this.createdAt,
    this.assignedAt,
    this.startedAt,
    this.completedAt,
    this.cancellationReason,
    this.attachments,
    this.progress,
    this.customFields,
  });

  factory ServiceOrder.fromJson(Map<String, dynamic> json) {
    return ServiceOrder(
      id: json['id'] as String,
      requestId: json['requestId'] as String,
      userId: json['userId'] as String,
      providerId: json['providerId'] as String?,
      title: json['title'] as String,
      description: json['description'] as String,
      categories: List<String>.from(json['categories'] as List),
      location: json['location'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      budget: json['budget'] as double,
      status: ServiceOrderStatus.values.firstWhere(
        (e) => e.toString() == 'ServiceOrderStatus.${json['status']}',
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
      assignedAt: json['assignedAt'] != null
          ? DateTime.parse(json['assignedAt'] as String)
          : null,
      startedAt: json['startedAt'] != null
          ? DateTime.parse(json['startedAt'] as String)
          : null,
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'] as String)
          : null,
      cancellationReason: json['cancellationReason'] as String?,
      attachments: json['attachments'] != null
          ? List<String>.from(json['attachments'] as List)
          : null,
      progress: json['progress'] != null
          ? (json['progress'] as List)
              .map((e) => ServiceOrderProgress.fromJson(e))
              .toList()
          : null,
      customFields: json['customFields'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'requestId': requestId,
      'userId': userId,
      'providerId': providerId,
      'title': title,
      'description': description,
      'categories': categories,
      'location': location,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'budget': budget,
      'status': status.toString().split('.').last,
      'createdAt': createdAt.toIso8601String(),
      'assignedAt': assignedAt?.toIso8601String(),
      'startedAt': startedAt?.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'cancellationReason': cancellationReason,
      'attachments': attachments,
      'progress': progress?.map((e) => e.toJson()).toList(),
      'customFields': customFields,
    };
  }

  String get statusText {
    switch (status) {
      case ServiceOrderStatus.pending:
        return 'order_status_pending'.tr;
      case ServiceOrderStatus.assigned:
        return 'order_status_assigned'.tr;
      case ServiceOrderStatus.inProgress:
        return 'order_status_in_progress'.tr;
      case ServiceOrderStatus.completed:
        return 'order_status_completed'.tr;
      case ServiceOrderStatus.cancelled:
        return 'order_status_cancelled'.tr;
      case ServiceOrderStatus.disputed:
        return 'order_status_disputed'.tr;
    }
  }
}

class ServiceOrderProgress {
  final String id;
  final String orderId;
  final String content;
  final DateTime timestamp;
  final String? imageUrl;
  final String updatedBy;
  final String? note;

  ServiceOrderProgress({
    required this.id,
    required this.orderId,
    required this.content,
    required this.timestamp,
    this.imageUrl,
    required this.updatedBy,
    this.note,
  });

  factory ServiceOrderProgress.fromJson(Map<String, dynamic> json) {
    return ServiceOrderProgress(
      id: json['id'] as String,
      orderId: json['orderId'] as String,
      content: json['content'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      imageUrl: json['imageUrl'] as String?,
      updatedBy: json['updatedBy'] as String,
      note: json['note'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderId': orderId,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
      'imageUrl': imageUrl,
      'updatedBy': updatedBy,
      'note': note,
    };
  }
} 