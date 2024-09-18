import 'dart:developer'; //log için

import 'package:flutter/material.dart';

import '../../widget/suptitle_text.dart';

class quantityBottomSheeedWidget extends StatelessWidget {
  const quantityBottomSheeedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Divider(
          indent: MediaQuery.of(context).size.width * 0.35,
          endIndent: MediaQuery.of(context).size.width * 0.35,
          thickness: 3,
          color: Color.fromARGB(255, 113, 113, 113),
        ),
        SizedBox(
          height: 20,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 25,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  log("index $index");
                },
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(4.0),
                    child: SubTitleTextWidget(
                      label: "${index + 1}",
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
