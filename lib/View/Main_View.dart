import 'package:card_swiper/card_swiper.dart';

import 'package:flutter/material.dart';
import 'package:library_user/Colors/app_constans.dart';
import 'package:library_user/Provider/Product_Provider.dart';
import 'package:library_user/Services/Assets_Manager.dart';
import 'package:library_user/widget/App_name_text.dart';
import 'package:library_user/widget/product/category_rounded_widget.dart';
import 'package:library_user/widget/product/top_product.dart';
import 'package:library_user/widget/suptitle_text.dart';
import 'package:provider/provider.dart';

import '../Provider/theme_provider.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final themaProvider = Provider.of<ThemeProvider>(context);
    Size size = MediaQuery.of(context).size; //Syafanın sizesi
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          //card yapti
        ),
        title: AppNameTextWidget(
          fontSize: 20,
          HeadText: 'Library',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15),
            SizedBox(
              height: size.height * 0.25,
              child: ClipRect(
                child: Swiper(
                  itemCount: AppConstans.bannerImage.length,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset(
                        AppConstans.bannerImage[index],
                        fit: BoxFit.fill,
                      ),
                    );
                  },
                  pagination: SwiperPagination(
                    builder: DotSwiperPaginationBuilder(
                      activeColor: Colors.orange, color: Colors.green, //Yuvarlağın rengi
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SubTitleTextWidget(
              label: "Most read",
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              height: size.height * 0.15,
              child: ListView.builder(
                itemCount: productProvider.getProducts.length <= 5
                    ? productProvider.getProducts.length
                    : 5, //        normalde olası gereken -->
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return ChangeNotifierProvider.value(
                    value: productProvider.getProducts[index],
                    child: TopProductWidget(),
                  );
                },
              ),
            ),
            SubTitleTextWidget(
              label: "Catogories",
            ),
            SizedBox(
              height: 15,
            ),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 4,
              physics: NeverScrollableScrollPhysics(),
              children: List.generate(
                AppConstans.cotogoriesList.length,
                (index) {
                  return CatogoryRoundedWidget(
                      image: AppConstans.cotogoriesList[index].image, name: AppConstans.cotogoriesList[index].name);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}



/*
         
            SwitchListTile(
                title: Text(themaProvider.getIsDerkTehme ? "Dark Mode" : "Light Mode"),
                value: themaProvider.getIsDerkTehme,
                onChanged: (value) {
                  print(value);
                  themaProvider.setDarkTheme(tehemeValue: value);
                })
                */
