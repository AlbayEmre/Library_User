import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:library_user/Provider/Product_Provider.dart';
import 'package:library_user/Provider/card_provider.dart';
import 'package:library_user/Provider/theme_provider.dart';
import 'package:library_user/View/Card/Card_Screen.dart';
import 'package:library_user/View/Main_View.dart';
import 'package:library_user/View/Profile_Screen.dart';
import 'package:library_user/View/Serach_Screen.dart';

import 'package:provider/provider.dart';

class RootScreen extends StatefulWidget {
  static const routName = "/RootScreen";
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  late List<Widget> screens;
  late bool isDarkTehme;
  late Color ActiveColor;
  late Color PasiveColor;
  int CurrentScreen = 0;
  double SelectedSize = 30;
  late PageController controller;
  bool _isLoadingBook = true;

  @override
  void initState() {
    super.initState();

    screens = [
      HomeView(),
      SearchScreen(),
      CardScreen(),
      ProfileScreen(),
    ];
    controller = PageController(initialPage: CurrentScreen);
  }

  Future<void> FetchBook() async {
    final productProvider = Provider.of<ProductProvider>(context, listen: false);

    try {
      //! Bitene kadar bekle
      Future.wait({
        productProvider.fetchProducts(),
      });
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  void didChangeDependencies() {
    if (_isLoadingBook) {
      FetchBook();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final cardProvider = Provider.of<CardProvider>(context);
    isDarkTehme = context.watch<ThemeProvider>().getIsDerkTehme;
    ActiveColor = isDarkTehme ? Colors.white : Colors.black;
    PasiveColor = isDarkTehme ? Colors.grey : Colors.grey;
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(), //Sğa sola gidiş yok
        controller: controller,
        children: screens,
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: context.watch<ThemeProvider>().getIsDerkTehme ? Colors.black : Colors.white,
        selectedIndex: CurrentScreen,
        height: kBottomNavigationBarHeight,
        onDestinationSelected: (index) {
          setState(() {
            CurrentScreen = index;
          });
          controller.jumpToPage(CurrentScreen);
        },
        destinations: [
          NavigationDestination(
            selectedIcon: Icon(
              size: SelectedSize,
              Icons.home,
              color: ActiveColor,
            ),
            icon: Icon(Icons.home_filled, color: PasiveColor),
            label: "Home",
          ),
          NavigationDestination(
              selectedIcon: Icon(
                size: SelectedSize,
                Icons.manage_search_sharp,
                color: ActiveColor,
              ),
              icon: Icon(Icons.search, color: PasiveColor),
              label: "Serach"),
          NavigationDestination(
              selectedIcon: Icon(
                size: SelectedSize,
                CupertinoIcons.bookmark_fill,
                color: ActiveColor,
              ),
              icon: cardProvider.getCardModel.length == 0
                  ? Icon(CupertinoIcons.bookmark)
                  : Badge(
                      alignment: Alignment.topRight,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      label: Text(cardProvider.getCardModel.length.toString()),
                      child: Icon(CupertinoIcons.bookmark, color: PasiveColor),
                    ),
              label: "received"),
          NavigationDestination(
              selectedIcon: Icon(
                size: SelectedSize,
                CupertinoIcons.person_alt,
                color: ActiveColor,
              ),
              icon: Icon(CupertinoIcons.person, color: PasiveColor),
              label: "Profile"),
        ],
      ),
    );
  }
}
