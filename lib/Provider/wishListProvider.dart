import 'package:flutter/material.dart';
import 'package:library_user/Model/wish_model.dart';
import 'package:uuid/uuid.dart';

//!   Uuid().v4() --> Benzersiz kimlikler oluşturmka için kulanulır
class WishListProvider with ChangeNotifier {
  final Map<String, WishListModel> _wishListItems = {};
  Map<String, WishListModel> get getwishList {
    return _wishListItems;
  }

  void add_OR_Remove_VishList({required String BookId}) {
    if (_wishListItems.containsKey(BookId)) {
      _wishListItems.remove(BookId);
    } else {
      _wishListItems.putIfAbsent(BookId, () => WishListModel(BookId: BookId, wishListID: Uuid().v4()));
    }
    notifyListeners();
  }

  bool isProdingWishLsit({required String BookID}) {
    return _wishListItems.containsKey(BookID);
  }

  void clearLochalWishList() {
    _wishListItems.clear();
    notifyListeners();
  }
}
