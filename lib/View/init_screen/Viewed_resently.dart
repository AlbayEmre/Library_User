import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:library_user/Provider/Viewed_Recently_Provider.dart';
import 'package:library_user/widget/product/product_widget.dart';

import 'package:provider/provider.dart';

import '../../Services/Assets_Manager.dart';
import '../../widget/suptitle_text.dart';
import '../Card/bottom_checkout.dart';
import '../Card/card_widget.dart';
import '../Card/emty_bag.dart';

class ViwedResentyScreen extends StatelessWidget {
  static const routName = "/ViwedResentyScreen";
  ViwedResentyScreen({super.key});
  bool isEmpty = true;
  @override
  Widget build(BuildContext context) {
    final viewProdProvider = Provider.of<ViewedProdProvidere>(context);
    return viewProdProvider.getViewedProd.isEmpty
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
                label: 'Viewed Recently',
              ),
            ),
            body: EmtyBagWidget(
              imagePath: AssetsManager.recently, //bagimg7 olmalı
              title: 'Your Viewed Recently is empty',
              buttonText: '',
              subtitle: 'Like your Viewed Recently is empty',
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
                label: 'Favorites ${viewProdProvider.getViewedProd.length}',
              ),
            ),
            body: DynamicHeightGridView(
                mainAxisSpacing: 10,
                crossAxisSpacing: 12,
                builder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ProductWidget(bookNameId: viewProdProvider.getViewedProd.values.toList()[index].BookId),
                  );
                },
                itemCount: viewProdProvider.getViewedProd.length,
                crossAxisCount: 2),
          );
  }
}
