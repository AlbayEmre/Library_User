import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:library_user/Model/book_model.dart';
import 'package:uuid/uuid.dart';

class ProductProvider with ChangeNotifier {
  List<BookModel> products = [];
  List<BookModel> get getProducts {
    return products;
  }

  BookModel? findByProId(String productId) {
    if (products.where((element) => element.bookId == productId).isEmpty) {
      return null;
    }

    return products.firstWhere((element) => element.bookId == productId);
  }

  List<BookModel> findByCategory({required String categoryName}) {
    List<BookModel> categoryList = products
        .where((element) => element.BookCatagory.toLowerCase().contains(
              categoryName.toLowerCase(),
            ))
        .toList();
    return categoryList;
  }

  List<BookModel> searchQuery({required String searchText, required List<BookModel> passedList}) {
    List<BookModel> searchList = passedList
        .where((element) => element.bookTitle.toLowerCase().contains(
              searchText.toLowerCase(),
            ))
        .toList();
    return searchList;
  }

  final productDb = FirebaseFirestore.instance.collection("books");
  Future<List<BookModel>> fetchProducts() async {
    try {
      await productDb.get().then((productSnapshot) {
        products.clear();

        for (var element in productSnapshot.docs) {
          products.insert(0, BookModel.fromFireStore(element));
        }
      });
      notifyListeners();
      return products;
    } catch (e) {
      rethrow;
    }
  }

  List<BookModel> productaa = [
    BookModel(
      bookId: "",
      bookTitle: "Beyaz Diş",
      BookCatagory: "Classical", //Roman Novel
      BookDescription: "Jack London'ın ünlü eseri Beyaz Diş...",
      bookQuantity: "10",
      bookWriter: "Jack London",
      BookImage: 'https://cdn.akakce.com/z/-/beyaz-dis-jack-london.jpg',
      Numberofpages: "256", Publisher: '',
    ),
    BookModel(
      bookId: "",
      bookTitle: "1984",
      BookCatagory: "Dystopian",
      BookDescription: "George Orwell'ın distopik romanı 1984...",
      bookQuantity: "15",
      bookWriter: "George Orwell",
      BookImage: 'https://i.dr.com.tr/cache/600x600-0/originals/0000000064038-1.jpg',
      Numberofpages: "328",
      Publisher: '',
    ),
    BookModel(
      bookId: "3",
      bookTitle: "Suç ve Ceza",
      BookCatagory: "Classical",
      BookDescription:
          "Fyodor Dostoyevsky's novel 'Crime and Punishment' is a profound work that takes place in 19th century Russia and tells the internal conflicts of a young student named Raskolnikov and the process of coming to terms with the consequences of his crime. While the internal struggle and remorse that begins with Raskolnikov's crime constitute the basic theme of the novel, it also questions social boundaries and moral values.",
      bookQuantity: "12",
      bookWriter: "Fyodor Dostoyevski",
      BookImage: 'https://i.dr.com.tr/cache/500x400-0/originals/0000000222780-1.jpg',
      Numberofpages: "560",
      Publisher: '',
    ),
    BookModel(
      bookId: "4",
      bookTitle: "Harry Potter ve Felsefe Taşı",
      BookCatagory: "Fantastic",
      BookDescription: "J.K. Rowling'in ilk Harry Potter kitabı...",
      bookQuantity: "20",
      bookWriter: "J.K. Rowling",
      BookImage: 'https://img.kitapyurdu.com/v1/getImage/fn:1109383/wh:true/miw:200/mih:200',
      Numberofpages: "336",
      Publisher: '',
    ),
    BookModel(
      bookId: "5",
      bookTitle: "Yerdeniz Büyücüsü",
      BookCatagory: "Fantastic",
      BookDescription: "Ursula K. Le Guin'in ünlü Yerdeniz serisi...",
      bookQuantity: "8",
      bookWriter: "Ursula K. Le Guin",
      BookImage: 'https://i.dr.com.tr/cache/600x600-0/originals/0000000057061-1.jpg',
      Numberofpages: "352",
      Publisher: '',
    ),
    BookModel(
      bookId: "6",
      bookTitle: "Beyaz Zambaklar Ülkesinde",
      BookCatagory: "Historical",
      BookDescription: "Grigory Petrov'un meşhur eseri Beyaz Zambaklar Ülkesinde...",
      bookQuantity: "5",
      bookWriter: "Grigory Petrov",
      BookImage: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRnHNE95-V8zu255h3t63SaATxUTljXiX2IJ1PyMLUdA&s',
      Numberofpages: "464",
      Publisher: '',
    ),
  ];
}
/*







  */
