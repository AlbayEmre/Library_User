// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class WishListModel with ChangeNotifier {
  final String wishListID;
  final String BookId;

  WishListModel({
    required this.BookId,
    required this.wishListID,
  });
}
