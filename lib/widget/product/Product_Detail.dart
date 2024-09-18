import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:library_user/Model/paswordModel.dart';
import 'package:library_user/Model/user_model.dart';
import 'package:library_user/Provider/Product_Provider.dart';
import 'package:library_user/Provider/card_provider.dart';
import 'package:library_user/Provider/user_Provider.dart';
import 'package:library_user/Services/myapp_functions.dart';
import 'package:library_user/widget/App_name_text.dart';
import 'package:library_user/widget/BookPasword_Validator.dart';
import 'package:library_user/widget/product/heart_button.dart';
import 'package:library_user/widget/suptitle_text.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  static const routName = "/ProductDetailScreen";

  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool _isLoading = true;
  UserModel? userModel;
  @override
  void initState() {
    super.initState();
    fetchUserInfo();
  }

  Future<void> fetchUserInfo() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      setState(() {
        _isLoading = true;
      });
      userModel = await userProvider.fetchUserInfo();

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
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final cardProvider = Provider.of<CardProvider>(context);
    String bookID = ModalRoute.of(context)!.settings.arguments as String;
    final getCurrProduct = productProvider.findByProId(bookID!);
    Size size = MediaQuery.of(context).size;

    GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    String? BoreowMinus() {
      if (!cardProvider.isProdinCard(productID: getCurrProduct!.bookTitle)) {
        return "Unit:" + getCurrProduct.bookQuantity;
      } else {
        int? Unit = int.tryParse(getCurrProduct.bookQuantity);
        int? result = Unit != null ? Unit - 1 : null;

        return "Unit:" + result.toString();
      }
    }

    return Scaffold(
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
        title: AppNameTextWidget(
          fontSize: 20,
          HeadText: 'Detail',
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : getCurrProduct == null
              ? SizedBox.shrink()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      FancyShimmerImage(
                        boxFit: BoxFit.fill,
                        imageUrl: getCurrProduct.BookImage,
                        height: size.height * 0.35,
                        width: size.width * 0.50,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    getCurrProduct.bookTitle,
                                    softWrap: true,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                SubTitleTextWidget(
                                  label: BoreowMinus().toString(),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(255, 255, 94, 0),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Color.fromARGB(255, 7, 234, 237),
                                  size: 10,
                                ),
                                Text(
                                  "Publisher: ",
                                  style: TextStyle(color: Color.fromARGB(255, 7, 234, 237)),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  getCurrProduct.Publisher,
                                  softWrap: true,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 7, 234, 237),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w200,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Color.fromARGB(255, 7, 234, 237),
                                  size: 10,
                                ),
                                Text(
                                  "Writer: ",
                                  style: TextStyle(color: Color.fromARGB(255, 7, 234, 237)),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  getCurrProduct.bookWriter,
                                  softWrap: true,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 7, 234, 237),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w200,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  HeardButtonWidget(
                                    bkgColors: Color.fromARGB(73, 157, 0, 255),
                                    bookID: getCurrProduct.bookTitle,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      height: kBottomNavigationBarHeight - 10,
                                      child: ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color.fromARGB(118, 254, 17, 0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30.0),
                                          ),
                                        ),
                                        onPressed: () async {
                                          GlobalKey<FormState> _formKey = GlobalKey<FormState>();

                                          bool isPasswordValid = await PaswordContoller.PaswordContollers(
                                            key: _formKey,
                                            context: context,
                                            subtitle: "Password",
                                            passwordList: OficerPasword.bookPasword,
                                          );

                                          print("Is Pasword Valid : ${isPasswordValid}");
                                          print("Model : ${userModel == null}");

                                          if (isPasswordValid && userModel != null) {
                                            if (!cardProvider.isProdinCard(productID: getCurrProduct.bookTitle)) {
                                              cardProvider.addProductCard(BookId: getCurrProduct.bookTitle);
                                            }
                                          }
                                        },
                                        icon: Icon(
                                          cardProvider.isProdinCard(productID: getCurrProduct.bookTitle)
                                              ? Icons.bookmark_added
                                              : Icons.bookmark_add_outlined,
                                        ),
                                        label: Text(
                                          cardProvider.isProdinCard(productID: getCurrProduct.bookTitle)
                                              ? "You already borrowed"
                                              : "This book borrow it",
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SubTitleTextWidget(label: "About this book"),
                                SubTitleTextWidget(
                                  label: getCurrProduct.BookCatagory,
                                  color: Colors.orange,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SubTitleTextWidget(
                              label: getCurrProduct.BookDescription,
                              fontSize: 14,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
