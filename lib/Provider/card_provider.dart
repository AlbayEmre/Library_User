import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../Model/card_model.dart';

class CardProvider with ChangeNotifier {
  final Map<String, CardModel> _cardItems = {};
  Map<String, CardModel> get getCardModel {
    return _cardItems;
  }

  void addProductCard({required String BookId}) {
    _cardItems.putIfAbsent(
        BookId, () => CardModel(BookId: BookId, DeadLine: DateTime.now(), cardId: Uuid().v4(), Quantity: 1));
    notifyListeners();
  }

  bool isProdinCard({required String productID}) {
    return _cardItems.containsKey(productID);
  }

  void removeOneItems({required String BookID}) {
    _cardItems.remove(BookID);
    notifyListeners(); //Bundan tüm ekranlar etkilenecek
  }
}
