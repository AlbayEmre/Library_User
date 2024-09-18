import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:library_user/Provider/Product_Provider.dart';
import 'package:library_user/Provider/Viewed_Recently_Provider.dart';
import 'package:library_user/Provider/card_provider.dart';
import 'package:library_user/Provider/theme_provider.dart';
import 'package:library_user/widget/product/Product_Detail.dart';
import 'package:library_user/widget/product/heart_button.dart';
import 'package:library_user/widget/suptitle_text.dart';

import 'package:provider/provider.dart';

class ProductWidget extends StatefulWidget {
  ProductWidget({super.key, required this.bookNameId});
  final String bookNameId;
  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final ViewedProvider = Provider.of<ViewedProdProvidere>(context);
    final cardProvider = Provider.of<CardProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final getCurrProduct = productProvider.findByProId(widget.bookNameId);
    return getCurrProduct == null
        ? SizedBox.shrink()
        : Padding(
            padding: EdgeInsets.all(0.0),
            child: GestureDetector(
              //-> tıklanmayı dinle (GestureDetector) ile
              onTap: () async {
                ViewedProvider.addViewProd(BookId: getCurrProduct.bookId);

                await Navigator.pushNamed(context, ProductDetailScreen.routName, arguments: getCurrProduct.bookId);
                //  Navigator.push(context, MaterialPageRoute(builder: (context) => const Placeholder()));
              },
              child: Container(
                decoration: !context.watch<ThemeProvider>().getIsDerkTehme
                    ? BoxDecoration(color: Color.fromARGB(30, 87, 164, 223), borderRadius: BorderRadius.circular(20))
                    : BoxDecoration(color: Color.fromARGB(39, 45, 59, 183), borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: FancyShimmerImage(
                        imageUrl: getCurrProduct.BookImage,
                        height: size.height * 0.2,
                        width: size.width * 0.4,
                      ),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Padding(
                      padding: EdgeInsets.all(2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 2,
                            child: SubTitleTextWidget(
                              label: getCurrProduct.bookTitle,
                              fontSize: 15,
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: HeardButtonWidget(
                              bookID: getCurrProduct.bookId,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 1.0,
                    ),
                    Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 1,
                            child: SubTitleTextWidget(
                              label: getCurrProduct.bookWriter, //!Yazar
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: Color.fromARGB(255, 0, 170, 255),
                            ),
                          ),
                          /*
                          Flexible(
                            child: Material(
                              borderRadius: BorderRadius.circular(12.0),
                              color: Colors.lightBlue,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () {
                                  if (cardProvider.isProdinCard(productID: getCurrProduct.bookId)) {
                                    return;
                                  }
                                  cardProvider.addProductCard(BookId: getCurrProduct.bookId);
                                },
                                splashColor: Colors.grey,
                                child: Padding(
                                  padding: EdgeInsets.all(2.0),
                                  child: Icon(
                                    
                                      cardProvider.isProdinCard(productID: getCurrProduct.bookId)
                                          ? Icons.check_rounded
                                          : Icons.bookmark_add_rounded), //sepet
                                ),
                              ),
                            ),
                          ),
                          */
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
