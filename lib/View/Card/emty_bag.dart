import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widget/suptitle_text.dart';

class EmtyBagWidget extends StatelessWidget {
  const EmtyBagWidget({
    super.key,
    required this.imagePath,
    required this.title,
    required this.buttonText,
    required this.subtitle,
  });
  final String imagePath, title, buttonText, subtitle;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Image.asset(
            imagePath,
            width: double.infinity,
            height: size.height * 0.35,
          ),
          SizedBox(height: 20),
          SubTitleTextWidget(
            label: "", //Daha sonra eklenebilinir
            fontSize: 40,
            color: Colors.red,
          ),
          SizedBox(
            height: 20,
          ),
          SubTitleTextWidget(
            label: title,
            fontWeight: FontWeight.w800,
            fontSize: 20,
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: SubTitleTextWidget(
              label: subtitle,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 20),
          buttonText != ""
              ? ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                  onPressed: () {},
                  child: Text(buttonText ?? ""))
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
