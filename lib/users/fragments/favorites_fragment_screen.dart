import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../model/products.dart';
import '../userPreferences/priduct_repository.dart';
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
        title: Text('Favorites', style: TextStyle(color: Colors.white)),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
              leading: Image.network(products[index].imagePath),
              title: Text(products[index].name),
              subtitle: Text('Price: \$${products[index].price}'),
              trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                IconButton(
                  icon: Icon(FontAwesomeIcons.basketShopping,
                      color: products[index].ordProducts
                          ? Colors.black
                          : Colors.grey),
                  onPressed: () {
                    toggleOrder(products[index]);
                  },
                ),
              ]));
        },
      ),
    );
  }

  void toggleOrder(ProductModel product) async {
    product.ordProducts = !product.ordProducts;
    setState(() {});

    await productRepository.updateProduct(product);
  }
}
