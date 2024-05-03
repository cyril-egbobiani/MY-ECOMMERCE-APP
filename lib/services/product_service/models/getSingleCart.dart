// // To parse this JSON data, do
// //
// //     final getSingleCart = getSingleCartFromJson(jsonString);

// import 'dart:convert';

// GetSingleCart getSingleCartFromJson(String str) =>
//     GetSingleCart.fromJson(json.decode(str));

// String getSingleCartToJson(GetSingleCart data) => json.encode(data.toJson());

// class GetSingleCart {
//   int? id;
//   int? userId;
//   DateTime? date;
//   List<Product>? products;
//   int? v;

//   GetSingleCart({
//     this.id,
//     this.userId,
//     this.date,
//     this.products,
//     this.v,
//   });

//   factory GetSingleCart.fromJson(Map<String, dynamic> json) => GetSingleCart(
//         id: json["id"],
//         userId: json["userId"],
//         date: DateTime.parse(json["date"]),
//         products: List<Product>.from(
//             json["products"].map((x) => Product.fromJson(x))),
//         v: json["__v"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "userId": userId,
//         "date": date!.toIso8601String(),
//         "products": List<dynamic>.from(products!.map((x) => x.toJson())),
//         "__v": v,
//       };
// }

// class Product {
//   int productId;
//   int quantity;

//   Product({
//     required this.productId,
//     required this.quantity,
//   });

//   factory Product.fromJson(Map<String, dynamic> json) => Product(
//         productId: json["productId"],
//         quantity: json["quantity"],
//       );

//   Map<String, dynamic> toJson() => {
//         "productId": productId,
//         "quantity": quantity,
//       };
// }
