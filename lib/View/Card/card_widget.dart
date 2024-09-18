import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:library_user/Model/paswordModel.dart';
import 'package:library_user/Model/user_model.dart';
import 'package:library_user/Provider/card_provider.dart';
import 'package:library_user/Provider/user_Provider.dart';
import 'package:library_user/Services/myapp_functions.dart';
import 'package:library_user/View/Card/quantity_BottomSheed.dart';
import 'package:library_user/widget/BookPasword_Validator.dart';
import 'package:provider/provider.dart';

import '../../Model/card_model.dart';
import '../../Provider/Product_Provider.dart';
import '../../widget/product/heart_button.dart';
import '../../widget/suptitle_text.dart';

class CardWidget extends StatefulWidget {
  const CardWidget({super.key});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  bool _isLoading = true;
  UserModel? userModel;
  Future<void> fetchUserInfo() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      setState(() {
        _isLoading = true;
      });
      userModel = await userProvider.fetchUserInfo();
      // Kullanıcı bilgisi başarıyla alındı
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      await MyAppFuncrions.showErrorOrWaningDialog(
        context: context,
        subtitle: error.toString(),
        fct: () {},
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    fetchUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final cardModel = Provider.of<CardModel>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final cardProvider = Provider.of<CardProvider>(context);

    final getCurrProduct = productProvider.findByProId(productProvider.getProducts.first.bookId);
    return getCurrProduct == Null
        ? Placeholder()
        : FittedBox(
            child: IntrinsicWidth(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: FancyShimmerImage(
                        //   boxFit: BoxFit.cover,
                        imageUrl: getCurrProduct!.BookImage,
                        height: size.height * 0.2,
                        width: size.width * 0.4,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    IntrinsicWidth(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: size.width * 0.6,
                                child: SubTitleTextWidget(label: getCurrProduct!.bookTitle),
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      GlobalKey<FormState> _formKey = GlobalKey<FormState>();

                                      bool isPasswordValid = await PaswordContoller.PaswordContollers(
                                        key: _formKey,
                                        context: context,
                                        subtitle: "Password",
                                        passwordList: OficerPasword.bookPasword,
                                      );

                                      if (isPasswordValid && userModel != null) {
                                        if (!cardProvider.isProdinCard(productID: getCurrProduct.bookTitle)) {
                                          cardProvider.addProductCard(BookId: getCurrProduct.bookTitle);
                                        }
                                      }
                                      cardProvider.removeOneItems(BookID: getCurrProduct.bookTitle);
                                    },
                                    icon: Icon(
                                      size: size.width * 0.1,
                                      Icons.clear_rounded,
                                      color: Colors.red,
                                    ),
                                  ),
                                  HeardButtonWidget(
                                    bookID: getCurrProduct.bookTitle,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                child: SubTitleTextWidget(label: getCurrProduct!.bookWriter),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SubTitleTextWidget(
                                label: cardModel.DeadLine.year.toString() +
                                    "." +
                                    cardModel.DeadLine.month.toString() +
                                    "." +
                                    cardModel.DeadLine.day.toString() +
                                    "-" +
                                    cardModel.DeadLine.year.toString() +
                                    "." +
                                    (cardModel.DeadLine.month + 1).toString() +
                                    "." +
                                    cardModel.DeadLine.day.toString(),
                                color: Colors.blue,
                              ),
                              Spacer(),
                              /*
                              OutlinedButton.icon(
                                onPressed: () async {
                                  await showModalBottomSheet(
                                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(40),
                                          topRight: Radius.circular(40),
                                        ),
                                      ),
                                      context: context,
                                      builder: (context) {
                                        return const quantityBottomSheeedWidget();
                                      });
                                },
                                icon: Icon(IconlyLight.arrow_down_2),
                                label: Text("QTY : 6"),
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(width: 1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                              ),
                              */
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
