import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  int? id;
  String? title;
  num? price;
  String? category;
  String? description;
  String? image;

  Product({
    this.id,
    this.title,
    this.price,
    this.category,
    this.description,
    this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        category: json["category"],
        description: json["description"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "category": category,
        "description": description,
        "image": image,
      };
}
