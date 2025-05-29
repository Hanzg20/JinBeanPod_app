import 'package:get/get.dart';

enum ServiceRequestStatus {
  pending, // 待审核
  approved, // 已通过，转化为订单
  rejected, // 已拒绝
  cancelled, // 已取消
}

class ServiceRequest {
  final String id;
  final String userId;
  final String title;
  final String description;
  final List<String> categories;
  final String location;
  final DateTime expectedStartDate;
  final DateTime expectedEndDate;
  final double budget;
  final ServiceRequestStatus status;
  final DateTime createdAt;
  final String? rejectionReason;
  final List<String>? attachments;
  final Map<String, dynamic>? customFields;

  ServiceRequest({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.categories,
    required this.location,
    required this.expectedStartDate,
    required this.expectedEndDate,
    required this.budget,
    required this.status,
    required this.createdAt,
    this.rejectionReason,
    this.attachments,
    this.customFields,
  });

  factory ServiceRequest.fromJson(Map<String, dynamic> json) {
    return ServiceRequest(
      id: json['id'] as String,
      userId: json['userId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      categories: List<String>.from(json['categories'] as List),
      location: json['location'] as String,
      expectedStartDate: DateTime.parse(json['expectedStartDate'] as String),
      expectedEndDate: DateTime.parse(json['expectedEndDate'] as String),
      budget: json['budget'] as double,
      status: ServiceRequestStatus.values.firstWhere(
        (e) => e.toString() == 'ServiceRequestStatus.${json['status']}',
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
      rejectionReason: json['rejectionReason'] as String?,
      attachments: json['attachments'] != null
          ? List<String>.from(json['attachments'] as List)
          : null,
      customFields: json['customFields'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'description': description,
      'categories': categories,
      'location': location,
      'expectedStartDate': expectedStartDate.toIso8601String(),
      'expectedEndDate': expectedEndDate.toIso8601String(),
      'budget': budget,
      'status': status.toString().split('.').last,
      'createdAt': createdAt.toIso8601String(),
      'rejectionReason': rejectionReason,
      'attachments': attachments,
      'customFields': customFields,
    };
  }

  String get statusText {
    switch (status) {
      case ServiceRequestStatus.pending:
        return 'request_status_pending'.tr;
      case ServiceRequestStatus.approved:
        return 'request_status_approved'.tr;
      case ServiceRequestStatus.rejected:
        return 'request_status_rejected'.tr;
      case ServiceRequestStatus.cancelled:
        return 'request_status_cancelled'.tr;
    }
  }
} 