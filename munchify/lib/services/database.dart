import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:munchify/models/group.dart';
import 'package:munchify/screens/tour/tour_config.dart';

class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

  // collection reference
  final CollectionReference<Map<String, dynamic>> userCollection =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference<Map<String, dynamic>> groupCollection =
      FirebaseFirestore.instance.collection('groups');

  Future<void> updateUserBalance(int addedBalance) async {
    final DocumentSnapshot<Map<String, dynamic>> userDoc = await userCollection.doc(uid).get();
    int oldBalance = userDoc.get('balance');
    await userCollection.doc(uid).update({'balance': oldBalance + addedBalance});
  }

  Future<void> createUser() async {
    try {
      await userCollection.doc(uid).set({
        'balance': 0,
        'groups': [],
      });
      print("User Added");
    } catch (error) {
      print("Failed to add user: $error");
    }
  }

  Future<int> getUserBalance() async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> userDoc = await userCollection.doc(uid).get();
      return (userDoc.get('balance'));
    } catch (error) {
      print("Failed to get user: $error");
      return 0;
    }
  }

  String imageUrl = 'groupPictures/Lunchify_Logo.png';
  bool imageSelected = false;

  Future<String> createGroup(String groupName) async {
    final QuerySnapshot<Map<String, dynamic>> groupSnapshot = await groupCollection.get();
    final int entryCount = groupSnapshot.docs.length;
    String groupid = groupName + entryCount.toString();

    await groupCollection.doc(groupid).set({
      'groupName': groupName,
      'createdBy': uid,
      'createdAt': DateTime.now(),
      'groupImage': imageUrl,
      'members': [uid],
      'active': false,
    });

    if (imageSelected) {
      await uploadGroupImage(groupid);
    }

    await userCollection.doc(uid).update({
      'groups': FieldValue.arrayUnion([groupid]),
    });

    return groupid;
  }


Future<List<String>> getGroups() async {
  try {
    final DocumentSnapshot<Map<String, dynamic>> userDoc = await userCollection.doc(uid).get();
    List<String> groups = List<String>.from(userDoc.get('groups') ?? []);

    print(groups);
    return groups;
  } catch (error) {
    print("Failed to get groups: $error");
    return [];
  }
}





/*
  Future<List<String>> getGroups() async {
    final DocumentSnapshot<Map<String, dynamic>> userDoc = await userCollection.doc(uid).get();
    List<String> groups = List<String>.from(userDoc.get('groups'));

    print(groups);

    List<Group> groupList = [];

    for (String group in groups) {
      print(group);
      DocumentSnapshot<Map<String, dynamic>> groupDoc = await groupCollection.doc(group).get();
      groupList.add(Group(
        name: groupDoc.get('groupName') ?? '',
        members: List<String>.from(groupDoc.get('members') ?? []),
        imageUrl: groupDoc.get('groupImage') ?? '',
        createdBy: groupDoc.get('createdBy') ?? '',
        createdAt: groupDoc.get('createdAt') ?? '',
      ));
    }
    print(groupList);
    return groups;
  }*/

  Future<int> getGroupCount() async {
    final DocumentSnapshot<Map<String, dynamic>> userDoc = await userCollection.doc(uid).get();
    return List<String>.from(userDoc.get('groups')).length;
  }

  Future<void> joinGroup(String groupid) async {
    final DocumentSnapshot<Map<String, dynamic>> groupDoc = await groupCollection.doc(groupid).get();

    // Adding uid to groupDocument
    List<String> groupMembers = List<String>.from(groupDoc.get('members'));
    groupMembers.add(uid);

    // Adding groupid to userDocument
    await userCollection.doc(uid).update({
      'groups': FieldValue.arrayUnion([groupid]),
    });

    await groupCollection.doc(groupid).update({'members': groupMembers});
  }

  PlatformFile? image;

  Future<PlatformFile?> selectImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png'],
    );

    if (result != null) {
      image = result.files.first;
      imageSelected = true;
      return image;
    }
    return null;
  }


  Future<void> uploadGroupImage(String groupid) async {
    if (image != null) {
      final path = 'groupPictures/$groupid/${image!.name}';
      final file = File(image!.path!);

      final snapshot = await FirebaseStorage.instance
          .ref()
          .child(path)
          .putFile(file);

      final urlDownload = await snapshot.ref.getDownloadURL();

      await groupCollection.doc(groupid).update({'groupImage': urlDownload});
      imageUrl = urlDownload;
    }
  }


  Future<void> startTour(String groupid) async {
    await groupCollection.doc(groupid).set({'active': true});

  }

  Future<void> endTour(String groupid, List<String> shoppingList, String runner, List<String> orderer, String destination) async {
    await groupCollection.doc(groupid).update({'active': false});
    // Add the recent tour details to the group's recentTours list
        final CollectionReference tourCollection = groupCollection.doc(groupid).collection('Tours');
    final String tourid = 'Tour' + (await tourCollection.get()).docs.length.toString();
    
    await tourCollection.doc(tourid).set({
      'shoppingList': shoppingList,
      'runner': runner,
      'orderer': orderer,
      'destination': destination,
      'createdAt': DateTime.now(),  // Optional: to keep track of when the tour was created
    });
  }


  Future<List<Map<String, dynamic>>> getRecentTours(String groupid) async {
    try {
      final groupDoc = await groupCollection.doc(groupid).get();
      List<Map<String, dynamic>> recentTours = [];
      if (groupDoc.exists && groupDoc.data() != null) {
        final tours = List<Map<String, dynamic>>.from(groupDoc.data()!['recentTours'] ?? []);
        recentTours = tours;
      }
      return recentTours;
    } catch (error) {
      print("Failed to get recent tours: $error");
      return [];
    }
  }


}
