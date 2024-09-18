// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CardModel with ChangeNotifier {
  final String cardId;
  final String BookId;
  final DateTime DeadLine;
  final int Quantity;
  DateTime now = DateTime.now();

  CardModel({
    required this.BookId,
    required this.DeadLine,
    required this.cardId,
    required this.Quantity,
  });
}
