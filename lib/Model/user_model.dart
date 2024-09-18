// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserModel with ChangeNotifier {
  final String userId;
  final String userName;
  final String userImage;
  final String userEmail;
  final Timestamp createdAt;
  final List userCard, userWish;
  UserModel({
    required this.userId,
    required this.userName,
    required this.userImage,
    required this.userEmail,
    required this.userCard,
    required this.createdAt,
    required this.userWish,
  });
}
