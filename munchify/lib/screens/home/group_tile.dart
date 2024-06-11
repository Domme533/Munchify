import 'package:flutter/material.dart';
import 'package:munchify/models/group.dart';

class GroupTile extends StatelessWidget {
  final Group group;
  GroupTile({required this.group});

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
