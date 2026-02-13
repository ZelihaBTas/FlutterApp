import 'package:flutter/material.dart';
import 'package:project_app/components/fav_button.dart';
import 'package:project_app/models/products_model.dart';

class ProductsCard extends StatelessWidget {
  final ProductsModel products;
  final ProductsModel productsCard;
  final Set<int> favIds;

  const ProductsCard({
    super.key,
    required this.products,
    required this.productsCard,
    required this.favIds,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [FavButton(products: products, favIds: favIds)],
            ),
            Hero(
              tag: productsCard.id,
              child: Image.network(
                productsCard.image,
                height: 150,
                width: double.infinity,
              ),
            ),

            SizedBox(height: 5),

            Text(
              productsCard.category,
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 4),

            Text(
              productsCard.title,
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.attach_money,
                      color: Color(0xFF2E7D32),
                      size: 20,
                    ),
                    Transform.translate(
                      offset: Offset(-4, 0),
                      child: Text(
                        productsCard.price.toString(),
                        style: TextStyle(
                          color: Color(0xFF2E7D32),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.star, color: Color(0xFFFFC107), size: 20),
                    Transform.translate(
                      offset: Offset(-1, 0),
                      child: Text(
                        productsCard.rating.rate.toString(),
                        style: TextStyle(
                          color: Color(0xFFFFC107),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(1, 0),
                      child: Text(
                        " (${productsCard.rating.count.toString()})",
                        style: TextStyle(
                          color: Color(0xFFFFC107),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
