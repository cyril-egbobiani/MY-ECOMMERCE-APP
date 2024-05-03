import 'product_model.dart';

class CartModel {
  final String id;
  final Product product;
  int quantity;

  CartModel({
    required this.id,
    required this.product,
    required this.quantity,
  });

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      id: map['id'].toString(),
      product: Product.fromJson(map['product']),
      quantity: map['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': product.toJson(),
      'quantity': quantity,
    };
  }

  CartModel updateQuantity(int newQuantity) {
    return CartModel(id: id, product: product, quantity: newQuantity);
  }
}
