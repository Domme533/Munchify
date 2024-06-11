import 'package:flutter/material.dart';
import 'package:munchify/models/group.dart';

class GroupTile extends StatelessWidget {
  final Group group;
  GroupTile({required this.group});


  Group _groupFromFirebase(Group group) {
    return Group(
      name: group.name,
      members: group.members,
      imageUrl: group.imageUrl,
      createdBy: group.createdBy,
      createdAt: group.createdAt,
      );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(8),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(group.imageUrl!),
        radius: 25,
      ),
      title: Text(group.name),
    );
  }
}