import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:library_user/Colors/theme_Data.dart';
import 'package:library_user/Provider/Product_Provider.dart';
import 'package:library_user/Provider/Viewed_Recently_Provider.dart';
import 'package:library_user/Provider/card_provider.dart';
import 'package:library_user/Provider/theme_provider.dart';
import 'package:library_user/Provider/user_Provider.dart';
import 'package:library_user/Provider/wishListProvider.dart';
import 'package:library_user/View/Out/Forgot_Password.dart';
import 'package:library_user/View/Out/login.dart';
import 'package:library_user/View/Out/register.dart';
import 'package:library_user/View/Serach_Screen.dart';
import 'package:library_user/View/init_screen/Viewed_resently.dart';
import 'package:library_user/View/init_screen/wishlist.dart';
import 'package:library_user/root_screen.dart';
import 'package:library_user/widget/Order/order_screen.dart';
import 'package:library_user/widget/product/Product_Detail.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseApp>(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          //Eyer başarısız olur ise
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: SelectableText(snapshot.error.toString()),
              ),
            ),
          );
        }
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) {
                return ThemeProvider();
              },
            ),
            ChangeNotifierProvider(
              create: (_) {
                return ProductProvider();
              },
            ),
            ChangeNotifierProvider(
              create: (_) {
                return CardProvider();
              },
            ),
            ChangeNotifierProvider(
              create: (_) {
                return WishListProvider();
              },
            ),
            ChangeNotifierProvider(
              create: (_) {
                return WishListProvider();
              },
            ),
            ChangeNotifierProvider(
              create: (_) {
                return ViewedProdProvidere();
              },
            ),
            ChangeNotifierProvider(
              create: (_) {
                return UserProvider();
              },
            ),
          ],
          child: Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: "MyLibrary",
                theme: styles.themeData(
                  isDarkTheme: themeProvider.getIsDerkTehme,
                  context: context,
                ),
                home: LoginScreen(), //RootScreen

                routes: {
                  ProductDetailScreen.routName: (context) => ProductDetailScreen(),
                  WishListScreen.routName: (context) => WishListScreen(),
                  ViwedResentyScreen.routName: (context) => ViwedResentyScreen(),
                  RegisterScreen.routName: (context) => RegisterScreen(),
                  OrderScreen.routName: (context) => OrderScreen(),
                  ForgotPassword.routName: (context) => ForgotPassword(),
                  SearchScreen.routName: (context) => SearchScreen(),
                  /*root */ RootScreen.routName: (context) => RootScreen(),
                  /*login */ LoginScreen.routName: (context) => LoginScreen(),
                },
              );
            },
          ),
        );
      },
    );
  }
}
