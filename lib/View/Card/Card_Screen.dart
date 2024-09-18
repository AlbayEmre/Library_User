import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Provider/card_provider.dart';
import '../../Services/Assets_Manager.dart';
import '../../widget/suptitle_text.dart';
import 'bottom_checkout.dart';
import 'card_widget.dart';
import 'emty_bag.dart';

class CardScreen extends StatelessWidget {
  CardScreen({super.key});
  bool isEmpty = false;
  @override
  Widget build(BuildContext context) {
    final cardProvider = Provider.of<CardProvider>(context);
    return cardProvider.getCardModel.isEmpty
        ? Scaffold(
            body: EmtyBagWidget(
              imagePath: AssetsManager.books, //card olmalı
              title: 'Borrowers is empty',
              buttonText: '', //Shop Now
              subtitle: "You haven't borrowed any books",
            ),
          )
        : Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
              ),
              title: SubTitleTextWidget(
                label: "Borrowed(${cardProvider.getCardModel.length})", //!Ekeme yaptımızda title kısmına sayı artacak
              ),
              actions: [
                /*
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                )
                */
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cardProvider.getCardModel.length,
                    itemBuilder: (context, index) {
                      return ChangeNotifierProvider.value(
                        value: cardProvider.getCardModel.values.toList()[index],
                        child: CardWidget(),
                      );
                    },
                  ),
                )
              ],
            ));
  }
}
