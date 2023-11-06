import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../model/products.dart';
import '../userPreferences/priduct_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
        title: Text('Order', style: TextStyle(color: Colors.white)),
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
                icon: Icon(Icons.favorite,
                    color: products[index].ordProducts
                        ? Colors.black
                        : Colors.grey),
                onPressed: () {
                  toggleFavorite(products[index]);
                },
              ),
            ]),
          );
        },
      ),
    );
  }

  void toggleFavorite(ProductModel product) async {
    product.favProduct = !product.favProduct;
    setState(() {});

    await productRepository.updateProduct(product);
  }
}
