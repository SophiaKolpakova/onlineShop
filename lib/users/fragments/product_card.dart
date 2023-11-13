import 'package:flutter/material.dart';
import '../model/products.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final Function() onFavoritePressed;
  final Function() onOrderPressed;
  final Function() onTap;

  const ProductCard({
    Key? key,
    required this.product,
    required this.onFavoritePressed,
    required this.onOrderPressed,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.network(
                product.imagePath[0],
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Price: \$${product.price}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: product.favProduct ? Colors.black : Colors.grey,
                  ),
                  onPressed: onFavoritePressed,
                ),
                IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: product.ordProducts ? Colors.black : Colors.grey,
                  ),
                  onPressed: onOrderPressed,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}