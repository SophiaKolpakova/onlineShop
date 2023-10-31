import 'package:flutter/material.dart';

class HomeFragmentScreen extends StatefulWidget {
  const HomeFragmentScreen({super.key});

  @override
  HomeFragmentScreenState createState() => HomeFragmentScreenState();
}

class HomeFragmentScreenState extends State<HomeFragmentScreen> {
  List<Product> products = [
    Product("Oversize black shirt", "images/num1.jpg", "47 €"),
    Product("Black suit fabric vest", "images/num22.jpg", "29 €"),
    Product("Beige anorak jacket ", "images/num33.jpg", "39 €"),
  ];
  List<Product> favorites = [];
  List<Product> cart = [];

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
                  leading: Image.asset(products[index].imagePath),
                  title: Text(products[index].name),
                  subtitle: Text('Price: \$${products[index].price}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.favorite, color: favorites.contains(products[index]) ? Colors.black : null),
                        onPressed: () {
                          toggleFavorite(products[index]);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.shopping_cart),
                        onPressed: () {
                          addToCart(products[index]);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
            },
            child: const Text('Place an order'),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  void toggleFavorite(Product product) {
    setState(() {
      if (favorites.contains(product)) {
        favorites.remove(product);
      } else {
        favorites.add(product);
      }
    });
  }

  void addToCart(Product product) {
    setState(() {
      cart.add(product);
    });
  }
}

class Product {
  final String name;
  final String imagePath;
  final String price;

  Product(this.name, this.imagePath, this.price);
}