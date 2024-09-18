import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:library_user/Colors/app_constans.dart';
import 'package:library_user/widget/suptitle_text.dart';

class OrderWidgetFree extends StatefulWidget {
  OrderWidgetFree({
    super.key,
  });

  @override
  State<OrderWidgetFree> createState() => _OrderWidgetFreeState();
}

class _OrderWidgetFreeState extends State<OrderWidgetFree> {
  DateTime suAn = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child:
                FancyShimmerImage(width: size.width * 0.25, height: size.height * 0.12, imageUrl: AppConstans.imageUrl),
          ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: SubTitleTextWidget(
                          fontSize: 16,
                          label: "Product Title ",
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.clear_outlined,
                          color: Colors.red,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SubTitleTextWidget(
                        fontSize: 13,
                        label: "Date received :",
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Flexible(
                        child: SubTitleTextWidget(
                          fontSize: 13,
                          label: "${suAn.year}-${suAn.month}-${suAn.day}",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Row(
                    children: [
                      SubTitleTextWidget(
                        fontSize: 13,
                        label: "Deadline:  ",
                      ),
                      Flexible(
                        child: SubTitleTextWidget(
                          fontSize: 13,
                          label: "${suAn.year}-${suAn.month + 1}-${suAn.day}",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
