import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:library_user/Provider/wishListProvider.dart';
import 'package:library_user/widget/product/product_widget.dart';
import 'package:provider/provider.dart';

import '../../Services/Assets_Manager.dart';
import '../../widget/suptitle_text.dart';
import '../Card/bottom_checkout.dart';
import '../Card/card_widget.dart';
import '../Card/emty_bag.dart';

class WishListScreen extends StatelessWidget {
  static const routName = "/WishListScreen";
  WishListScreen({super.key});
  bool isEmpty = false;
  @override
  Widget build(BuildContext context) {
    final wishListProvider = Provider.of<WishListProvider>(context);
    return wishListProvider.getwishList.isEmpty
        ? Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                icon: Icon(Icons.arrow_back_ios),
              ),
              title: SubTitleTextWidget(
                label: 'Favorites',
              ),
            ),
            body: EmtyBagWidget(
              imagePath: AssetsManager.favorite, //bagimg7 olmalı
              title: 'Favorites are empty',
              buttonText: '',
              subtitle: 'Your favorite book list is empty',
            ),
          )
        : Scaffold(
            // bottomSheet: CardBottomSheetWidget(),
            appBar: AppBar(
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                icon: Icon(Icons.arrow_back_ios),
              ),
              title: SubTitleTextWidget(
                label: 'Favorites ${wishListProvider.getwishList.length}',
              ),
            ),
            body: DynamicHeightGridView(
                mainAxisSpacing: 10,
                crossAxisSpacing: 12,
                builder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ProductWidget(bookNameId: wishListProvider.getwishList.values.toList()[index].BookId),
                  );
                },
                itemCount: wishListProvider.getwishList.length,
                crossAxisCount: 2),
          );
  }
}
