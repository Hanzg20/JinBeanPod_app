class Event {
  final String id;
  final String title;
  final String description;
  final String image;
  final DateTime startTime;
  final DateTime endTime;
  final String location;
  final int participantsCount;
  final int maxParticipants;
  final bool isJoined;
  final String organizerId;
  final String organizerName;
  final String communityId;
  final String communityName;
  final List<String> tags;
  final bool isFree;
  final double? price;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.participantsCount,
    required this.maxParticipants,
    this.isJoined = false,
    required this.organizerId,
    required this.organizerName,
    required this.communityId,
    required this.communityName,
    required this.tags,
    required this.isFree,
    this.price,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      location: json['location'] as String,
      participantsCount: json['participantsCount'] as int,
      maxParticipants: json['maxParticipants'] as int,
      isJoined: json['isJoined'] as bool? ?? false,
      organizerId: json['organizerId'] as String,
      organizerName: json['organizerName'] as String,
      communityId: json['communityId'] as String,
      communityName: json['communityName'] as String,
      tags: List<String>.from(json['tags'] as List),
      isFree: json['isFree'] as bool,
      price: json['price'] as double?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'location': location,
      'participantsCount': participantsCount,
      'maxParticipants': maxParticipants,
      'isJoined': isJoined,
      'organizerId': organizerId,
      'organizerName': organizerName,
      'communityId': communityId,
      'communityName': communityName,
      'tags': tags,
      'isFree': isFree,
      'price': price,
    };
  }

  bool get isUpcoming => startTime.isAfter(DateTime.now());
  bool get isOngoing => startTime.isBefore(DateTime.now()) && endTime.isAfter(DateTime.now());
  bool get isPast => endTime.isBefore(DateTime.now());
  bool get isFull => participantsCount >= maxParticipants;
} 