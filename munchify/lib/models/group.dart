import 'package:cloud_firestore/cloud_firestore.dart';

class Group {
  final String name;
  final List<String> members;
  final String? imageUrl;
  final String createdBy;
  final DateTime createdAt;

  Group({
    required this.name,
    required this.members,
    this.imageUrl,
    required this.createdBy,
    required this.createdAt,
  });

  factory Group.fromMap(Map<String, dynamic> data) {
    return Group(
      name: data['groupName'] ?? '',
      members: List<String>.from(data['members'] ?? []),
      imageUrl: data['groupImage'],
      createdBy: data['createdBy'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }
}
