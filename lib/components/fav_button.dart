import 'package:flutter/material.dart';
import 'package:project_app/models/products_model.dart';

class FavButton extends StatefulWidget {
  final ProductsModel products;
  final Set<int> favIds;
  const FavButton({super.key, required this.products, required this.favIds});

  @override
  State<FavButton> createState() => _FavButtonState();
}

class _FavButtonState extends State<FavButton> {
  Set<int> favIds = {};

  @override
  Widget build(BuildContext context) {
    bool isFav = widget.favIds.contains(widget.products.id);
    return IconButton(
      onPressed: () {
        setState(() {
          if (!isFav) {
            widget.favIds.add(widget.products.id);
          } else {
            widget.favIds.remove(widget.products.id);
          }
        });
      },
      icon: Icon(isFav ? Icons.favorite : Icons.favorite_border_outlined),
      color: isFav ? Color(0xFFFF0000) : Colors.black,
    );
  }
}
