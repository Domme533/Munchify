import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:munchify/models/user.dart';
import 'package:munchify/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on FirebaseUser
  IUser _userFromFirebaseUser(User user) {
    return IUser(uid: user.uid);
  }

  // auth change user stream
  Stream<IUser> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromFirebaseUser(user!));
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user!;

      // create a new document for the user with the uid
      await DatabaseService(uid: user.uid).createUser();
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  String getCurrentUser() {
    return _auth.currentUser?.uid ?? '';
  }
}
