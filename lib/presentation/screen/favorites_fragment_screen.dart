import 'package:flutter/material.dart';
import 'package:shop/presentation/screen/product_card.dart';
import 'package:shop/presentation/screen/product_details_screen.dart';
import '../../data/model/product_model.dart';
import '../../data/repo/product_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoritesFragmentScreen extends StatefulWidget {
  FavoritesFragmentScreen();

  @override
  _FavoritesFragmentScreenState createState() =>
      _FavoritesFragmentScreenState();
}

class _FavoritesFragmentScreenState extends State<FavoritesFragmentScreen> {
  ProductRepositoryImpl productRepository =
      ProductRepositoryImpl(FirebaseFirestore.instance);

  List<ProductModel> products = [];

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  void loadProducts() async {
    List<ProductModel> fetchedProducts =
        await productRepository.getFavProducts();
    setState(() {
      products = fetchedProducts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Favorites', style: TextStyle(color: Colors.white)),
      ),
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
