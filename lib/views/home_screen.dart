import 'package:flutter/material.dart';
import 'package:project_app/components/products_card.dart';
import 'package:project_app/models/products_model.dart';
import 'package:project_app/services/api_service.dart';
import 'package:project_app/services/local_storage_sevice.dart';
import 'package:project_app/views/basket_screen.dart';
import 'package:project_app/views/favorite_screen.dart';
import 'package:project_app/views/product_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LocalStorageService localStorageService = LocalStorageService();
  String username = "";
  TextEditingController searchController = TextEditingController();
  ApiService apiService = ApiService();
  List<ProductsModel> allproducts = [];
  bool isLoading = false;
  String errorMessage = "";
  Set<int> basketIds = {};
  Set<int> favIds = {};

  Future<void> loadUsername() async {
    final name = await localStorageService.getData();
    setState(() {
      username = name;
    });
  }

  Future<void> fetchProducts() async {
    try {
      setState(() {
        isLoading = true;
      });

      final data = await apiService.fetchProducts();

      setState(() {
        allproducts = data;
      });
    } catch (e) {
      setState(() {
        errorMessage = "Error Caught";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    loadUsername();
    fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Welcome $username",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FavoriteScreen(
                                products: allproducts,
                                favIds: favIds,
                              ),
                            ),
                          );
                        },
                        icon: Icon(Icons.favorite_border_outlined),
                      ),

                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BasketScreen(
                                products: allproducts,
                                basketIds: basketIds,
                              ),
                            ),
                          );
                        },
                        icon: Icon(Icons.shopping_cart_outlined),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 10),

              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFEBEBEF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: "Search products",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),

              SizedBox(height: 16),

              Expanded(
                child: isLoading
                    ? Center(child: CircularProgressIndicator())
                    : errorMessage != ""
                    ? Text(errorMessage)
                    : ListView.builder(
                        itemCount: allproducts.length,
                        itemBuilder: (context, index) {
                          final products = allproducts[index];

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailScreen(
                                    products: products,
                                    basketIds: basketIds,
                                    favIds: favIds,
                                  ),
                                ),
                              );
                            },
                            child: ProductsCard(
                              productsCard: products,
                              favIds: favIds,
                              products: products,
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
