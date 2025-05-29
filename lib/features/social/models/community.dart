class Community {
  final String id;
  final String name;
  final String description;
  final String image;
  final int membersCount;
  final int postsCount;
  final bool isJoined;
  final List<String> tags;
  final String location;

  Community({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.membersCount,
    required this.postsCount,
    this.isJoined = false,
    required this.tags,
    required this.location,
  });

  factory Community.fromJson(Map<String, dynamic> json) {
    return Community(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      membersCount: json['membersCount'] as int,
      postsCount: json['postsCount'] as int,
      isJoined: json['isJoined'] as bool? ?? false,
      tags: List<String>.from(json['tags'] as List),
      location: json['location'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'membersCount': membersCount,
      'postsCount': postsCount,
      'isJoined': isJoined,
      'tags': tags,
      'location': location,
    };
  }
} 