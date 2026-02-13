import 'package:flutter/material.dart';
import 'package:project_app/models/products_model.dart';

class BasketScreen extends StatefulWidget {
  final List<ProductsModel> products;
  final Set<int> basketIds;
  const BasketScreen({
    super.key,
    required this.products,
    required this.basketIds,
  });

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  @override
  Widget build(BuildContext context) {
    final basketProducts = widget.products
        .where((product) => widget.basketIds.contains(product.id))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Shopping Basket", style: TextStyle(color: Colors.black)),
        leadingWidth: 20,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          children: [
            basketProducts.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.shopping_cart_outlined,
                          size: 64,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Your shopping basket is empty",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: basketProducts.length,
                      itemBuilder: (context, index) {
                        final item = basketProducts[index];

                        return Padding(
                          padding: EdgeInsetsGeometry.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    widget.basketIds.remove(item.id);
                                  });
                                },
                                icon: Icon(Icons.remove_circle_outline),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
            SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: Size(double.infinity, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text("Buy", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
