import 'package:flutter/material.dart';
import 'package:project_app/models/products_model.dart';

class FavoriteScreen extends StatefulWidget {
  final List<ProductsModel> products;
  final Set<int> favIds;
  const FavoriteScreen({
    super.key,
    required this.products,
    required this.favIds,
  });

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    final favProducts = widget.products
        .where((product) => widget.favIds.contains(product.id))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("My Favorites", style: TextStyle(color: Colors.black)),
      ),
      body: SafeArea(
        child: favProducts.isEmpty
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.favorite, size: 64, color: Colors.grey),
                    SizedBox(height: 4),
                    Text(
                      "You have no favorites yet.",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: favProducts.length,
                itemBuilder: (context, index) {
                  final item = favProducts[index];

                  return Padding(
                    padding: EdgeInsetsGeometry.all(10),
                    child: Row(
                      children: [
                        Image.network(item.image, width: 70, height: 70),

                        SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(item.category),
                              Row(
                                children: [
                                  Icon(
                                    Icons.attach_money,
                                    color: Color(0xFF2E7D32),
                                    size: 20,
                                  ),
                                  Transform.translate(
                                    offset: Offset(-4, 0),
                                    child: Text(
                                      item.price.toString(),
                                      style: TextStyle(
                                        color: Color(0xFF2E7D32),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        IconButton(
                          onPressed: () {
                            setState(() {
                              widget.favIds.remove(item.id);
                            });
                          },
                          icon: Icon(Icons.favorite),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
