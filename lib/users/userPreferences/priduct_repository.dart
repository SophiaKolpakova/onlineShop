import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/products.dart';

class ProductRepositoryImpl {
  final FirebaseFirestore _firestore;

  ProductRepositoryImpl(this._firestore);


  Future<List<ProductModel>> getProducts() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('products').get();
      List<ProductModel> products = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return ProductModel.fromJson(doc.id, data);
      }).toList();
      return products;
    } catch (e) {
      print('Error getting products: $e');
      return [];
    }
  }

  Future<List<ProductModel>> getFavProducts() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('products').get();
      List<ProductModel> favProducts = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return ProductModel.fromJson(doc.id, data);
      }).toList().where((element) => element.favProduct).toList();
      return favProducts;
    } catch (e) {
      print('Error getting products: $e');
      return [];
    }
  }


  Future<void> updateProduct(ProductModel product) async {
    try {
      await _firestore.collection('products').doc(product.prId).update(product.toJson());
      print('Product updated successfully');
    } catch (e) {
      print('Error updating product: $e');
    }
  }
}