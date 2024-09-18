import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:library_user/Model/book_model.dart';
import 'package:library_user/Provider/Viewed_Recently_Provider.dart';
import 'package:library_user/widget/product/Product_Detail.dart';
import 'package:library_user/widget/product/heart_button.dart';

import 'package:provider/provider.dart';

import '../../Provider/card_provider.dart';

class TopProductWidget extends StatelessWidget {
  const TopProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final cardProvider = Provider.of<CardProvider>(context);
    final ProductModel = Provider.of<BookModel>(context);
    final ViewedProvider = Provider.of<ViewedProdProvidere>(context);

    return Padding(
      padding: EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async {
          ViewedProvider.addViewProd(BookId: ProductModel.bookId);

          await Navigator.pushNamed(context, ProductDetailScreen.routName, arguments: ProductModel.bookId);
        },
        child: SizedBox(
          width: size.width * 0.45,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: FancyShimmerImage(
                    imageUrl: ProductModel.BookImage,
                    height: size.width * 0.24,
                    width: size.height * 0.32,
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Flexible(
                  child: Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    ProductModel.bookTitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  FittedBox(
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: HeardButtonWidget(
                            bookID: ProductModel.bookId,
                          ),
                        ),
                        /*
                        IconButton(
                          onPressed: () {
                            if (cardProvider.isProdinCard(productID: ProductModel.bookId)) {
                              return;
                            }
                            cardProvider.addProductCard(BookId: ProductModel.bookId);
                          },
                          icon: Icon(
                           
                              cardProvider.isProdinCard(productID: ProductModel.bookId)
                                  ? Icons.check_rounded
                                  : Icons.bookmark_add_rounded),
                        ),
                        */
                      ],
                    ),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
