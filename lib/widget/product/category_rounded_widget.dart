import 'package:flutter/material.dart';
import 'package:library_user/View/Serach_Screen.dart';
import 'package:library_user/widget/suptitle_text.dart';

class CatogoryRoundedWidget extends StatelessWidget {
  CatogoryRoundedWidget({super.key, required this.image, required this.name});

  final String image;
  final String name;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, SearchScreen.routName, arguments: name);
      },
      child: Column(
        children: [
          Image.asset(
            image,
            height: 50,
            width: 50,
          ),
          SizedBox(
            height: 5,
          ),
          SubTitleTextWidget(
            label: name,
            fontSize: 11,
            fontWeight: FontWeight.w900,
          ),
        ],
      ),
    );
  }
}
