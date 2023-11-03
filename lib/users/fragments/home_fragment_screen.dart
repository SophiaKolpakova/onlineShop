import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop/users/userPreferences/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/products.dart';
import 'package:shop/users/userPreferences/priduct_repository.dart';

class HomeFragmentScreen extends StatefulWidget {
  HomeFragmentScreen();

  @override
  HomeFragmentScreenState createState() => HomeFragmentScreenState();
}

class HomeFragmentScreenState extends State<HomeFragmentScreen> {
  ProductRepositoryImpl productRepository =
      ProductRepositoryImpl(FirebaseFirestore.instance);

  List<ProductModel> products = [];

  HomeFragmentScreenState();

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  void loadProducts() async {
    List<ProductModel> fetchedProducts = await productRepository.getProducts();
    setState(() {
      products = fetchedProducts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.network(products[index].imagePath),
                  title: Text(
                    products[index].name,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text('Price: \$${products[index].price}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      )),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.favorite,
                            color: products[index].favProduct
                                ? Colors.black
                                : Colors.grey),
                        onPressed: () {
                          toggleFavorite(products[index]);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void toggleFavorite(ProductModel product) async {
    product.favProduct = !product.favProduct;
    setState(() {});

    await productRepository.updateProduct(product);
  }
}
