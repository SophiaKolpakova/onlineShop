import 'package:flutter/material.dart';
import 'package:shop/presentation/screen/product_card.dart';
import '../../data/model/product_model.dart';
import '../../data/repo/product_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'product_details_screen.dart';

class OrderFragmentScreen extends StatefulWidget {
  OrderFragmentScreen();

  @override
  _OrderFragmentScreenState createState() => _OrderFragmentScreenState();
}

class _OrderFragmentScreenState extends State<OrderFragmentScreen> {
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
        await productRepository.getOrderProducts();
    setState(() {
      products = fetchedProducts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Order', style: TextStyle(color: Colors.white)),
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
