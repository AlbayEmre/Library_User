import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BookModel with ChangeNotifier {
  final String bookId;
  final String bookTitle;
  final String BookCatagory;
  final String BookDescription;
  final String BookImage;
  final String bookQuantity;
  final String bookWriter;
  final String Numberofpages;
  final String Publisher;
  Timestamp? createdAt;

  BookModel(
      {required this.bookId,
      required this.bookTitle,
      required this.BookCatagory,
      required this.BookDescription,
      required this.BookImage,
      required this.bookQuantity,
      required this.bookWriter,
      required this.Numberofpages,
      required this.Publisher,
      this.createdAt});

  factory BookModel.fromFireStore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return BookModel(
      bookId: data["bookId"],
      bookTitle: data["bookTitle"],
      BookCatagory: data["BookCatagory"],
      BookDescription: data["BookDescription"],
      BookImage: data["BookImage"],
      bookQuantity: data["bookQuantity"],
      bookWriter: data["bookWriter"],
      Numberofpages: data["Numberofpages"],
      Publisher: data["Publisher"],
      createdAt: data["createdAt"],
    );
  }
}
