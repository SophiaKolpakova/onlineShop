import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/products.dart';
import '../userPreferences/priduct_repository.dart';
import 'product_details_screen.dart';
import 'product_card.dart';

class HomeFragmentScreen extends StatefulWidget {
  const HomeFragmentScreen({Key? key}) : super(key: key);

  @override
  HomeFragmentScreenState createState() => HomeFragmentScreenState();
}

class HomeFragmentScreenState extends State<HomeFragmentScreen> {
  ProductRepositoryImpl productRepository =
  ProductRepositoryImpl(FirebaseFirestore.instance);

  List<ProductModel> products = [];

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  product: products[index],
                  onFavoritePressed: () {
                    toggleFavorite(products[index]);
                  },
                  onOrderPressed: () {
                    toggleOrder(products[index]);
                  },
                  onTap: () {
                    navigateToProductDetails(products[index]);
                  },
                );
              },
            ),
          ],
        ),
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

  void navigateToProductDetails(ProductModel product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsScreen(product: product),
      ),
    );
  }
}
