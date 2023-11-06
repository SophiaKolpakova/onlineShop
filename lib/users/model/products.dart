import '../userPreferences/auth_repository.dart';

class ProductModel {
  String prId;
  String name;
  String imagePath;
  int price;
  bool favProduct;
  bool ordProducts;

  ProductModel(this.prId, this.name, this.imagePath, this.price,
      this.favProduct, this.ordProducts);

  factory ProductModel.fromJson(String prId, Map<String, dynamic> json) {
    return ProductModel(
      prId,
      json['name'] as String,
      json['imagePath'] as String,
      json['price'] as int,
      json['favProduct'] as bool,
      json['ordProducts'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'imagePath': imagePath,
        'price': price,
        'favProduct': favProduct,
        'ordProducts': ordProducts
      };
}
