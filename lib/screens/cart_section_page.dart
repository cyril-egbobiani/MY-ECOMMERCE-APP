import 'dart:convert';

import 'package:final_tutrorial/color.dart';
import 'package:final_tutrorial/services/product_service/models/cart_model.dart';
import 'package:final_tutrorial/services/product_service/models/product_model.dart';
import 'package:flutter/cupertino.dart';
// import 'package:final_tutrorial/services/product_service/product_repo_impl.dart';
// import 'package:final_tutrorial/services/product_service/product_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/snackbar.dart';

class CartSection extends StatefulWidget {
  final Product productCart;
  const CartSection({super.key, required this.productCart});

  @override
  State<CartSection> createState() => _CartSectionState();
}

class _CartSectionState extends State<CartSection> {
  late SharedPreferences prefs;

  List<Product> productList = <Product>[];
  List<Product> selectedProducts = <Product>[];
  List<CartModel> cartList = <CartModel>[];

  fetchCart() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    String? cartString = _prefs.getString('userCart');
    if (cartString != null) {
      List<dynamic> _cartList = jsonDecode(cartString);
      List<CartModel> updatedCartList =
          _cartList.map((item) => CartModel.fromMap(item)).toList();

      showSnackBar('Items fetched');

      setState(() {
        cartList = updatedCartList;
        print("*******cart list length ${cartList.length}");
      });
    } else {
      debugPrint('error');
    }
  }

  deleteLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    cartList.clear();

    setState(() {});
  }

  removeItem(Product product) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    print("new cartList length ${cartList.length}");

    cartList.removeWhere((e) => e.product.id == product.id);

    String cartString = jsonEncode(cartList);

    await prefs.setString("userCart", cartString);

    setState(() {});

    showSnackBar("Item removed");
  }

  @override
  void initState() {
    fetchCart();
    super.initState();
  }

  add(Product product) async {
    try {
      debugPrint(product.toJson().toString());
      SharedPreferences _prefs = await SharedPreferences.getInstance();

      var specificProduct = cartList
          .where((element) => element.product.id == product.id)
          .toList();

      specificProduct.first.quantity = specificProduct.first.quantity + 1;

      String cartString = jsonEncode(cartList);

      await _prefs.setString("userCart", cartString);

      setState(() {});
    } catch (e) {
      debugPrint("i am pressing here $e");
    }
  }

  remove(Product product) async {
    try {
      debugPrint(product.toJson().toString());
      SharedPreferences _prefs = await SharedPreferences.getInstance();

      var specificProduct = cartList
          .where((element) => element.product.id == product.id)
          .toList();

      if (specificProduct.first.quantity == 1) {
        removeItem(product);
      } else {
        specificProduct.first.quantity = specificProduct.first.quantity - 1;
      }

      String cartString = jsonEncode(cartList);

      await _prefs.setString("userCart", cartString);

      setState(() {});
    } catch (e) {
      debugPrint("error for remove method : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Column(
            children: [
              Text(
                'Cart',
                style:
                    TextStyle(fontFamily: 'CabinetGrotesk-Bold', fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '${cartList.length} items in cart',
                style:
                    TextStyle(fontFamily: 'CabinetGrotesk-Bold', fontSize: 16),
              )
            ],
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                // Add your notification functionality here
                deleteLocalStorage();
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: cartList.map((e) => cartItemWidget(e)).toList(),
              ),
            )
          ]),
        ));
  }

  Widget cartItemWidget(CartModel item) {
    return Container(
      margin: EdgeInsets.only(
        top: 10,
      ),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white12,
          borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.all(20),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Image.network(
                item.product.image ?? '',
                width: 50,
              ),
            ],
          ),
          const SizedBox(
            width: 30,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 200,
                    child: Text(
                      item.product.title ?? '',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      removeItem(item.product);
                    },
                    child: Container(
                      child: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 7,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 100,
                    child: Text(
                      '\$${item.product.price.toString()}',
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            remove(item.product);
                          },
                          child: Icon(Icons.remove)),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: blue,
                        ),
                        height: 20,
                        width: 20,
                        child: Center(child: Text(item.quantity.toString())),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                          onTap: () {
                            add(item.product);
                          },
                          child: Icon(
                            Icons.add,
                          )),
                    ],
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
