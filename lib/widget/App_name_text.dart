import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:library_user/Provider/theme_provider.dart';
import 'package:library_user/widget/suptitle_text.dart';

import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class AppNameTextWidget extends StatelessWidget {
  AppNameTextWidget({super.key, this.fontSize = 30, required this.HeadText, this.isShimer = true, this.TextColor});

  final bool isShimer;
  final double fontSize;
  final String HeadText;
  final Color? TextColor;
  @override
  Widget build(BuildContext context) {
    return (context.watch<ThemeProvider>().getIsDerkTehme && isShimer)
        ? Shimmer.fromColors(
            period: Duration(seconds: 10),
            baseColor: Colors.blue,
            highlightColor: const Color.fromARGB(255, 76, 0, 206), //Eskisi -> deepPurple
            child: SubTitleTextWidget(label: HeadText, fontSize: fontSize, fontWeight: FontWeight.bold),
          )
        : SubTitleTextWidget(
            label: HeadText,
            fontSize: fontSize,
            fontWeight: FontWeight.normal,
            color: TextColor,
          );
  }
}
