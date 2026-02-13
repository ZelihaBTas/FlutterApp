import 'package:flutter/material.dart';
import 'package:project_app/components/fav_button.dart';
import 'package:project_app/models/products_model.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductsModel products;
  final Set<int> basketIds;
  final Set<int> favIds;

  const ProductDetailScreen({
    super.key,
    required this.products,
    required this.basketIds,
    required this.favIds,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Back", style: TextStyle(color: Colors.black)),
        leadingWidth: 20,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FavButton(products: widget.products, favIds: widget.favIds),
                ],
              ),

              Hero(
                tag: widget.products.id,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.network(
                    widget.products.image,
                    height: 300,
                    width: double.infinity,
                    //fit: BoxFit.cover,
                  ),
                ),
              ),

              SizedBox(height: 2),

              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.products.title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey.shade800,
                      ),
                    ),

                    SizedBox(height: 2),

                    Text(
                      widget.products.category,
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.grey,
                      ),
                    ),

                    SizedBox(height: 10),

                    Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey.shade700,
                      ),
                    ),

                    SizedBox(height: 2),

                    Text(widget.products.description),

                    SizedBox(height: 10),

                    Row(
                      children: [
                        const Icon(
                          Icons.attach_money,
                          color: Color(0xFF2E7D32),
                          size: 28,
                        ),
                        Transform.translate(
                          offset: Offset(-4, 0),
                          child: Text(
                            widget.products.price.toString(),
                            style: TextStyle(
                              color: Color(0xFF2E7D32),
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          widget.basketIds.add(widget.products.id);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Added to basket."),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.green.shade600,
                            margin: EdgeInsets.only(
                              bottom: 70,
                              left: 20,
                              right: 20,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        minimumSize: Size(double.infinity, 45),
                      ),
                      child: Text(
                        "Add to cart",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
