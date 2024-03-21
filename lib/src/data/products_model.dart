class ProductsModel {
  List<Product>? productsList;

  ProductsModel.fromJson(Map<String, dynamic> json) {
    productsList = [];
    for (var product in json['products']) {
      productsList!.add(Product.fromJson(product));
    }
  }
}

class Product {
  int? id;
  String? title;
  String? description;
  int? price;
  int? stock;
  String? brand;
  String? category;
  String? thumbnail;
  List<String>? images;

  Product({
    this.id,
    this.title,
    this.description,
    this.price,
    this.stock,
    this.brand,
    this.category,
    this.thumbnail,
    this.images,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    stock = json['stock'];
    brand = json['brand'];
    category = json['category'];
    thumbnail = json['thumbnail'];
    images = [];
    for (var image in json['images']) {
      images!.add(image);
    }
  }
}
