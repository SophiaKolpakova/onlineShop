import 'package:flutter/material.dart';
import '../model/products.dart';
import '../userPreferences/priduct_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FavoritesFragmentScreen extends StatefulWidget {

  FavoritesFragmentScreen();

  @override
  _FavoritesFragmentScreenState createState() => _FavoritesFragmentScreenState();
}

class _FavoritesFragmentScreenState extends State<FavoritesFragmentScreen> {

  ProductRepositoryImpl productRepository = ProductRepositoryImpl(FirebaseFirestore.instance);

  List<ProductModel> products = [];


  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  void loadProducts() async {
    List<ProductModel> fetchedProducts = await productRepository.getFavProducts();
    setState(() {
      products = fetchedProducts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Favorites', style: TextStyle(color: Colors.white)),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.network(products[index].imagePath),
            title: Text(products[index].name),
            subtitle: Text('Price: \$${products[index].price}'),
          );
        },
      ),
    );
  }
}