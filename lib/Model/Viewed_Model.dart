// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ViewedModel with ChangeNotifier {
  final String viewedID;
  final String BookId;

  ViewedModel({
    required this.BookId,
    required this.viewedID,
  });
}
