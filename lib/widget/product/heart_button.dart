import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import 'package:provider/provider.dart';

import '../../Provider/wishListProvider.dart';

class HeardButtonWidget extends StatefulWidget {
  const HeardButtonWidget({super.key, this.bkgColors = Colors.transparent, this.size = 20, required this.bookID});

  final Color bkgColors;
  final double size;
  final String bookID;
  @override
  State<HeardButtonWidget> createState() => _HeardButtonWidgetState();
}

class _HeardButtonWidgetState extends State<HeardButtonWidget> {
  @override
  Widget build(BuildContext context) {
    final wishListProvider = Provider.of<WishListProvider>(context);
    return Container(
      decoration: BoxDecoration(
        color: widget.bkgColors,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        style: IconButton.styleFrom(elevation: 10),
        onPressed: () {
          wishListProvider.add_OR_Remove_VishList(BookId: widget.bookID);
        },

        icon: Icon(wishListProvider.isProdingWishLsit(BookID: widget.bookID) ? IconlyBold.heart : IconlyLight.heart),
        color: wishListProvider.isProdingWishLsit(BookID: widget.bookID) ? Colors.red : Colors.grey,

        //   icon: Icon(IconlyLight.heart),
      ),
    );
  }
}
