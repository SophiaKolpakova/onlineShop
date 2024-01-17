

class ProductModel {
  String prId;
  String name;
  List<String> imagePath;
  int price;
  bool favProduct;
  bool ordProducts;
  String description;

  ProductModel(this.prId, this.name, this.imagePath, this.price,
      this.favProduct, this.ordProducts, this.description);

  factory ProductModel.fromJson(String prId, Map<String, dynamic> json) {
    return ProductModel(
      prId,
      json['name'] as String,
      (json['imagePath'] as List<dynamic>).cast<String>(),
      json['price'] as int,
      json['favProduct'] as bool,
      json['ordProducts'] as bool,
      json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'imagePath': imagePath,
        'price': price,
        'favProduct': favProduct,
        'ordProducts': ordProducts,
        'description': description,
      };
}
