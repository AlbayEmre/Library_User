import 'package:flutter/material.dart';
import 'package:library_user/Model/Viewed_Model.dart';
import 'package:library_user/Model/wish_model.dart';
import 'package:uuid/uuid.dart';

//!   Uuid().v4() --> Benzersiz kimlikler oluşturmka için kulanulır
class ViewedProdProvidere with ChangeNotifier {
  final Map<String, ViewedModel> _ViewedProdItems = {};
  Map<String, ViewedModel> get getViewedProd {
    return _ViewedProdItems;
  }

  void addViewProd({required String BookId}) {
    _ViewedProdItems.putIfAbsent(
      BookId,
      () => ViewedModel(
        BookId: BookId,
        viewedID: Uuid().v4(),
      ),
    );
  }
}
