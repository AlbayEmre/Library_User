import 'package:flutter/material.dart';

import '../../widget/suptitle_text.dart';

class CardBottomSheetWidget extends StatelessWidget {
  const CardBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: const Border(
          top: BorderSide(width: 1, color: Colors.red),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: SizedBox(
          height: kBottomNavigationBarHeight + 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      child: SubTitleTextWidget(label: "Total 6 Product 9 items"),
                    ),
                    SubTitleTextWidget(
                      label: "Fiyat 16.0\$",
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text("CheckOut"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
