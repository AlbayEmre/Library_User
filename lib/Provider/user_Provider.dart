import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:library_user/Model/user_model.dart';

class UserProvider with ChangeNotifier {
  UserModel? userModel;
  UserModel? get getUserModel {
    return userModel;
  }

  Future<UserModel?> fetchUserInfo() async {
    final auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user == null) {
      return null;
    }
    String uid = user.uid;
    try {
      final userDoc = await FirebaseFirestore.instance.collection("users").doc(uid).get();

      final userDocDict = userDoc.data() as Map<String, dynamic>?;
      userModel = UserModel(
        userId: userDoc.get("userId"),
        userName: userDoc.get("userName"),
        userImage: userDoc.get("userImage"),
        userEmail: userDoc.get("userEmail"),
        createdAt: userDoc.get("createdAt"),
        userCard: userDocDict!.containsKey("userCart") ? userDoc.get("userCart") : [],
        userWish: userDocDict!.containsKey("userWish") ? userDoc.get("userWish") : [],
      );
      return userModel;
    } on FirebaseException catch (error) {
      rethrow;
    } catch (error) {
      rethrow;
    }
  }
}
