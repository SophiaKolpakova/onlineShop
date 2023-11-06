
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shop/users/userPreferences/auth_repository.dart';
import '../model/products.dart';
import 'package:shop/users/userPreferences/priduct_repository.dart';

class HomeFragmentScreen extends StatefulWidget {
  const HomeFragmentScreen({super.key});

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
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text('Price: \$${products[index].price}',
                      style: const TextStyle(
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
                      IconButton(
                        icon: Icon(FontAwesomeIcons.basketShopping,
                            color: products[index].ordProducts
                                ? Colors.black
                                : Colors.grey),
                        onPressed: () {
                          toggleOrder(products[index]);
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

  void toggleOrder(ProductModel product) async {
    product.ordProducts = !product.ordProducts;
    setState(() {});

    await productRepository.updateProduct(product);
  }
}
