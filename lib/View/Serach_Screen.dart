import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';

import 'package:flutter/material.dart';
import 'package:library_user/Model/book_model.dart';
import 'package:provider/provider.dart';

import '../Provider/Product_Provider.dart';
import '../widget/App_name_text.dart';
import '../widget/product/product_widget.dart';
import '../widget/suptitle_text.dart';

class SearchScreen extends StatefulWidget {
  static const routName = "/SearchScreen";
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController searchTextController;

  @override
  void initState() {
    searchTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  List<BookModel> productListSearch = [];

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    String? passedCatogory = ModalRoute.of(context)!.settings.arguments as String?; //Gelen veri
    List<BookModel> bookList = passedCatogory == null
        ? productProvider.products
        : productProvider.findByCategory(categoryName: passedCatogory);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: AppNameTextWidget(
            fontSize: 20,
            HeadText: passedCatogory ?? 'Book Serach ',
          ),
        ),
        body: bookList.isEmpty
            ? const Center(
                child: Text("There aren't any books"),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 15.0,
                    ),
                    TextField(
                      controller: searchTextController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              FocusScope.of(context).unfocus();
                              searchTextController.text = "";
                            });
                          },
                          child: Icon(
                            Icons.close_sharp,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      onChanged: (value) {},
                      onSubmitted: (value) {
                        setState(() {
                          productListSearch =
                              productProvider.searchQuery(searchText: searchTextController.text, passedList: bookList);
                        });
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (searchTextController.text.isNotEmpty && productListSearch.isEmpty) ...[
                      Center(
                        child: SubTitleTextWidget(
                          label: "No Book Found",
                        ),
                      ),
                    ],
                    Expanded(
                      child: DynamicHeightGridView(
                        mainAxisSpacing: 12,
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        itemCount: searchTextController.text.isNotEmpty ? productListSearch.length : bookList.length,
                        builder: (context, index) {
                          print("Book List: ${bookList.length}");
                          print("Search Text: ${searchTextController.text}");
                          print("Search Results: ${productListSearch.length}");
                          return ProductWidget(
                            //  bookNameId: bookList[index].bookTitle,
                            bookNameId: searchTextController.text.isNotEmpty
                                ? productListSearch[index].bookId
                                : bookList[index].bookId,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

/*

                                */