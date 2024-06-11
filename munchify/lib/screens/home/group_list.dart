import 'package:flutter/material.dart';
import 'package:munchify/models/group.dart';
import 'package:provider/provider.dart';
import 'package:munchify/screens/home/group_tile.dart';

class GroupList extends StatefulWidget {
  const GroupList({super.key});

  @override
  State<GroupList> createState() => _GroupListState();
}

class _GroupListState extends State<GroupList> {
  @override
  Widget build(BuildContext context) {
    final groups = Provider.of<List<Group>>(context);


    return ListView.builder(
      shrinkWrap: true,
      itemCount: groups.length,
      itemBuilder: (context, index) {
        return GroupTile(group: groups[index]);
      },
    );
  }
}
